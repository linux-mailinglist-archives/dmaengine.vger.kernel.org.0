Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B210538A0E
	for <lists+dmaengine@lfdr.de>; Tue, 31 May 2022 05:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243675AbiEaDAp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 30 May 2022 23:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbiEaDAo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 30 May 2022 23:00:44 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6738D6AC;
        Mon, 30 May 2022 20:00:43 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id s24so9476738wrb.10;
        Mon, 30 May 2022 20:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pVuKTlsFDvJFeQ9fSgBWrUZpUIPWJSWwNPRVXl0JeGI=;
        b=K/ufnd/iFa7FlGXPxfbCp1orkHjJJji1utQ7ks56XADOonZAbnLtaW+4Ren9TmG5Pz
         Izv8eqg/ehDLwjIuBtZOwT1xX1ToZH5SpNeQ5riS3kJeWsO2S1i2OfyBVaGvqnX+rZI0
         yswuLBrQiacjXMWnhtX0oxLZCOSd4ieCDOlBjmET2f//KrIzK8wYveZvz5ro1lqLJ2ro
         LjcBCKsLSVaF8Fqx9QR6nYaNOJheT9AaZlSAO81Rtl9L5G12AlbsTgMd4RktGWTUFxUS
         4FcXMtTbc6OpjgDIAmrUPbOUgwk25jELKZrXYToRTjD+O2JL+V8csn0QsESZYDgz1itk
         wrFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pVuKTlsFDvJFeQ9fSgBWrUZpUIPWJSWwNPRVXl0JeGI=;
        b=H7koeDmzud/SuLS/Ii9YxyotOBeigThrHlD5q/VTHry0DsUMsNnfTfWeGUSx81EeGj
         wM5F01hnmFD0NlzlB2KxfVDxKBbPIVTTqhMiTJZosmBb5JPGi2jPEzp5gyHAVZZkvXbl
         hUzwNUtVXKMhnUkk3XfUJET/ExjthLemb7FPQQKR9RlI/Dx3UiXQKvjr/O5crEJ4O+Xu
         8JEJm9Md0TE+Auf7dJ/29akrZ3CzVxyBtnEGBjHyWx49vCfUee9/K9ZQ2lS0ILmAiAz7
         BDTAzEeFrC+y54i9a6aKly9it3eIjetv3LMu0SEqi5t5SNYR4q+DuIPkxuublrULfx2K
         FFWg==
X-Gm-Message-State: AOAM5306vXVpm0GXGY8aFrnDNuPZ+ZwJJtbZHrWBNlAqR/P4yze0uWfC
        f/oJejrJM9jqDrKFsRT/ycA=
X-Google-Smtp-Source: ABdhPJwotxfYmnUs8DsqAn8sh5ula5ZCaCu4Q0MeGWIh5fTsjc3pT0eLuwV6tqoh6rYPefuYJRQppw==
X-Received: by 2002:a05:6000:178d:b0:20f:e960:2f2 with SMTP id e13-20020a056000178d00b0020fe96002f2mr31673284wrg.569.1653966041855;
        Mon, 30 May 2022 20:00:41 -0700 (PDT)
Received: from olivier-3493erg ([2a01:e34:ec42:fd70:8e84:c3a8:e5ed:7183])
        by smtp.gmail.com with ESMTPSA id 12-20020a5d47ac000000b0020c6b78eb5asm11576977wrb.68.2022.05.30.20.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 20:00:41 -0700 (PDT)
Date:   Tue, 31 May 2022 05:00:39 +0200
From:   Olivier dautricourt <olivierdautricourt@gmail.com>
To:     Nam Cao <namcaov@gmail.com>
Cc:     vkoul@kernel.org, sr@denx.de, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: altera-msgdma: correct mutex locking order
Message-ID: <YpWE11ZI5MyyhtlD@olivier-3493erg>
References: <20220529182306.GA26782@nam-dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220529182306.GA26782@nam-dell>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun, May 29, 2022 at 08:23:06PM +0200, Nam Cao wrote:
> The order of spin_unlock and spin_lock seems wrong. Correct it.
> 
> Signed-off-by: Nam Cao <namcaov@gmail.com>
> ---
> Changes in v2:
> 	- Get rid of dirty index problem due to the patch being manually editted.
> 
>  drivers/dma/altera-msgdma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
> index 6f56dfd375e3..e35096c12abc 100644
> --- a/drivers/dma/altera-msgdma.c
> +++ b/drivers/dma/altera-msgdma.c
> @@ -591,9 +591,9 @@ static void msgdma_chan_desc_cleanup(struct msgdma_device *mdev)
>  
>  		dmaengine_desc_get_callback(&desc->async_tx, &cb);
>  		if (dmaengine_desc_callback_valid(&cb)) {
> -			spin_unlock(&mdev->lock);
> -			dmaengine_desc_callback_invoke(&cb, NULL);
>  			spin_lock(&mdev->lock);
> +			dmaengine_desc_callback_invoke(&cb, NULL);
> +			spin_unlock(&mdev->lock);
>  		}
>  
>  		/* Run any dependencies, then free the descriptor */
> -- 
> 2.25.1
> 
Hello,

the lock is first grabbed in msgdma_tasklet.

Kr,

Olivier
