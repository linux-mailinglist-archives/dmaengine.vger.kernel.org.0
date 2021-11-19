Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D3B457785
	for <lists+dmaengine@lfdr.de>; Fri, 19 Nov 2021 20:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbhKSUCc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 19 Nov 2021 15:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236169AbhKSUCU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 19 Nov 2021 15:02:20 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF37CC061574;
        Fri, 19 Nov 2021 11:59:17 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id b40so48302714lfv.10;
        Fri, 19 Nov 2021 11:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=j3zFh+wRLO9Q64j8kSaIpaKz65+6JS9leQyBRevKpgM=;
        b=S1VEMn/+oR1ioE/QuqMGamM5lhp7U4tPMF4ud0qpRYZ9QyPlNV3Hp77L1Y0ngcTIA+
         J0pBC0+LfufY30qvOQy2RgW0kiha3mQ+jTSTNWnYfyisEYYzgaVpwwBCEqVyePlAzLmD
         p9W/vKxvjLuqlvJ2MwSU+lKX/sUZfI+9PA/+pxIoTeCEC0rz4o/hTb3vrf0ugJp6NnnW
         1hB+FFk/KByeW+g6dtm8tGtvqDZuYWeCPFYOHM3LIkE9mUF19HyZDPFkl30Au2YB1KqD
         cN0Iqr9HBGzmznmGX356YMykbnbzGnB3EwEB8ST5G0yqWPhEVwDdjyrgg6Lnr4IKkHyj
         g96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=j3zFh+wRLO9Q64j8kSaIpaKz65+6JS9leQyBRevKpgM=;
        b=4y9OrPKLLAmW9zIiRFpe7BwFSG7zKcR5IAkh11VErap2dqVMDpkuv71rrzx2+Wt/y4
         B4dX69I3VlI+962iy/r+uTqqxCKSsxG0HN76IWh7XFPvQp5DwvY2U2tWVByD0eacX15O
         dAU9NFjnCnhybJohrQOkKKtLmUKgHK00MIysIPe3Op0JI/ibnK4/acUQ3merCgcq3lC1
         LfqN1YtmuXcujwMM3WwlGEwWbQjr3zfA/OgjCKMxzuDg2gZYIBK9MK/4Snm0YdjQEqxy
         ZuiXccouaLnQEYCE9MPOaFGdX6Mi9E2GN7uDjFZfZfkOfJ430cUzrQBW644jHv0q5LMP
         XRpg==
X-Gm-Message-State: AOAM530grQDPyQMibQMRgZCP8zQMaqYQFDTSfp9er6sH0/NsWl6g2MLU
        TOWyS0ySIv7lg9zTcQVmy74=
X-Google-Smtp-Source: ABdhPJwnUQFO4cSaradvKrTRPwnAK0i153LCDAJTFz53grS6CIS7KugtUTnb2dFfWGdEo7oDk51K8Q==
X-Received: by 2002:a2e:aa14:: with SMTP id bf20mr28395243ljb.376.1637351955978;
        Fri, 19 Nov 2021 11:59:15 -0800 (PST)
Received: from [10.0.0.115] (91-153-170-164.elisa-laajakaista.fi. [91.153.170.164])
        by smtp.gmail.com with ESMTPSA id l12sm77248lfk.212.2021.11.19.11.59.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 11:59:15 -0800 (PST)
Message-ID: <3dcce108-dcd0-59f9-33cc-061ec0f1bbfe@gmail.com>
Date:   Fri, 19 Nov 2021 21:59:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] dmaengine: ti: edma: Use 'for_each_set_bit' when possible
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <47a7415d3aff8dfb66780bd6f80b085db4503bf7.1637263609.git.christophe.jaillet@wanadoo.fr>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <47a7415d3aff8dfb66780bd6f80b085db4503bf7.1637263609.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 18/11/2021 21:28, Christophe JAILLET wrote:
> Use 'for_each_set_bit()' instead of hand wrinting it. It is much less
> version.

Thanks for the patch!

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>


> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/dma/ti/edma.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
> index caa4050ecc02..08e47f44d325 100644
> --- a/drivers/dma/ti/edma.c
> +++ b/drivers/dma/ti/edma.c
> @@ -1681,8 +1681,7 @@ static irqreturn_t dma_ccerr_handler(int irq, void *data)
>  
>  			dev_dbg(ecc->dev, "EMR%d 0x%08x\n", j, val);
>  			emr = val;
> -			for (i = find_first_bit(&emr, 32); i < 32;
> -			     i = find_next_bit(&emr, 32, i + 1)) {
> +			for_each_set_bit(i, &emr, 32) {
>  				int k = (j << 5) + i;
>  
>  				/* Clear the corresponding EMR bits */
> 

-- 
Péter
