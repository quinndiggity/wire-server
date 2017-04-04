module Ropes.Aws.Ses where

import Aws.Ses
import Control.Applicative
import Control.Monad.IO.Class
import Data.ByteString.Lazy (toStrict)
import Network.Mail.Mime

import Prelude


-- | Convenience function for constructing a 'SendRawEmail' command,
-- which involves extracting/duplicating some data from the MIME 'Mail'.
sendRawEmail :: MonadIO m => Mail -> m SendRawEmail
sendRawEmail m = do
    msg <- liftIO $ toStrict <$> renderMail' m
    return $ SendRawEmail
        (map addressEmail (mailTo m))
        (RawMessage msg)
        (Just . Sender . addressEmail $ mailFrom m)
