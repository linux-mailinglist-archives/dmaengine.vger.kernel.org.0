Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0460C5007B
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jun 2019 06:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfFXEU0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 24 Jun 2019 00:20:26 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39783 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfFXEU0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 24 Jun 2019 00:20:26 -0400
Received: by mail-pl1-f193.google.com with SMTP id b7so6134532pls.6
        for <dmaengine@vger.kernel.org>; Sun, 23 Jun 2019 21:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nZ3QRIuWBeN4EIN6rH472NgcMumZTsiAmDYM8AODHwM=;
        b=vPUColFibeg0CIhonzXTI5Op23NPE86nWMEgbUhOcZOuQj/E8224BHYFrAPiimxZFr
         LN14H4klBZsaejFBkzzzprilLbhckZbmzQ5mHLN5gaXzfDMCvkoDJvdJcreaBWeyQ4Zk
         f7yzpRs5DGfjopLJO2ZXpnWF6HOpICv8jRhm2YDtI/hDI8GbxbhcbZRUg+Qa+lm8WBkw
         l768tptPBuVSWP1klhgbJOUVbESlR1h01LruZKszMLGSUuW0k9vxOcSqMID+uBIo5ecU
         PtB9aec9u8OpIcuDYZJd3hf1EJDBpCGJuIHM8YYKKtIcEYnt1y8uWYNqxGdhqjsCMDUN
         sDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nZ3QRIuWBeN4EIN6rH472NgcMumZTsiAmDYM8AODHwM=;
        b=EbxEbYHvNIhWzxz2SrfcIM/bXK3QW+vM/hqKRMztEsEqUSZM5xfeGEZyweUAJtcmG7
         74qoRg5QivV40oyWLqMmflZHwd8CuJE0l/eIg5Nafpg7i1xsPezNYS3+txVoc110F3ax
         VhGE8iRjDnLxCESvmYKKBa1ktlHkhuggNDr8I/wRUbe0WfD73bCquuvh8BXaxHFUq3vv
         OoA3KV71fUlMDV0XMM3NLEzMpobQviTf4r7NGv3gojRFh1Op10+kBiNcOvxV7iA9ejBo
         0oo2zom+ushc9pyJKinVtE4HEPqgiB8waBmV9XEph3aobEt4KrLIGwr7qJSlSqCxpOQd
         VYIQ==
X-Gm-Message-State: APjAAAVoWTbLer+82lZT7HdNGX8tTlsQYYTpKE/i00+riPOeOzWUTp5Y
        j+Vpe0scq08PqOzGVlTWSsy3VA==
X-Google-Smtp-Source: APXvYqxt3H49kF1VT4GxECxTx44UoTHBLe/mn2pFEsqK6AczG32m8mzY9VB1gIYGEK0CGMr4ZDeNGQ==
X-Received: by 2002:a17:902:e6:: with SMTP id a93mr103419114pla.175.1561350025272;
        Sun, 23 Jun 2019 21:20:25 -0700 (PDT)
Received: from localhost ([122.172.211.128])
        by smtp.gmail.com with ESMTPSA id f10sm9681608pfd.151.2019.06.23.21.20.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 21:20:23 -0700 (PDT)
Date:   Mon, 24 Jun 2019 09:50:21 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, dmaengine@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v1] dmaengine: dw: Enable iDMA 32-bit on Intel Elkhart
 Lake
Message-ID: <20190624042021.43gbrnywzjeqnftd@vireshk-i7>
References: <20190621131914.38855-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621131914.38855-1-andriy.shevchenko@linux.intel.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-06-19, 16:19, Andy Shevchenko wrote:
> Intel Elkhart Lake OSE (Offload Service Engine) provides few DMA controllers
> to the host. Enable them in the driver.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/dma/dw/pci.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/dma/dw/pci.c b/drivers/dma/dw/pci.c
> index c69e80d97220..7a53c6a94957 100644
> --- a/drivers/dma/dw/pci.c
> +++ b/drivers/dma/dw/pci.c
> @@ -143,6 +143,11 @@ static const struct pci_device_id dw_pci_id_table[] = {
>  	{ PCI_VDEVICE(INTEL, 0x2286), (kernel_ulong_t)&dw_pci_data },
>  	{ PCI_VDEVICE(INTEL, 0x22c0), (kernel_ulong_t)&dw_pci_data },
>  
> +	/* Elkhart Lake iDMA 32-bit (OSE DMA) */
> +	{ PCI_VDEVICE(INTEL, 0x4bb4), (kernel_ulong_t)&idma32_pci_data },
> +	{ PCI_VDEVICE(INTEL, 0x4bb5), (kernel_ulong_t)&idma32_pci_data },
> +	{ PCI_VDEVICE(INTEL, 0x4bb6), (kernel_ulong_t)&idma32_pci_data },
> +
>  	/* Haswell */
>  	{ PCI_VDEVICE(INTEL, 0x9c60), (kernel_ulong_t)&dw_pci_data },
>  

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
