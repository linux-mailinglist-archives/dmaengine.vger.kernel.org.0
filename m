Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14AD213F6DD
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jan 2020 20:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437091AbgAPTHr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Jan 2020 14:07:47 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34548 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388029AbgAPRBM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Jan 2020 12:01:12 -0500
Received: by mail-lj1-f194.google.com with SMTP id z22so23512927ljg.1;
        Thu, 16 Jan 2020 09:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=88l0VtjSeRj4yj9KcO4Ldi0UeGaxeOpGhThJBxiypGU=;
        b=eMXtmtCgIIH0/XFjc5PFo5qHjAdac7CgfxMWDej1J3zBtOGjCTqdPUxljged1QU/YD
         NRYf+KFWDMx+Ie4Xx5HedjUFhqisumDOF9V201Y750IUihHre+vdvuO78WNKQgo5pHMz
         Dr25PTaKyTwokeQuxgx9RPqdMz3MvKUboQz/Mu0vBU5jWluNgyCltbrX6BCanscVWekH
         hoGikwL3fW9YF5OUPwxOwYc7N30Lsq4Jltay5w5vqfBdl6LcuBcPRRBDCoH1W+XjQ6ls
         53C9RfgG+eg/Lt3CESaABuyLVFtzeNFTsn+um5ClLoTTLGPQZRJ1eKelqWDA3saLym8V
         2LKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=88l0VtjSeRj4yj9KcO4Ldi0UeGaxeOpGhThJBxiypGU=;
        b=dtrrwb0eGbnPXMuvW+5dWFHzv1+LW86V9+hBGgOlVKDEl4x3P2b6dKQTg4/BzlC55X
         LG+o4sGhxtq6BHaR8ghplnA7F3055X909HfexOF0gaJX3EmZDGBX9F6lDWMlAuZ20aNo
         BfGcnBNRqd7dt8KNbzmz1VkgT/sapnGGwU+8FqMor0+BM69+BW7BNzBr1rE7rBUY8aNr
         Ll8J4XSCjXm9p55DdVzkWpG3GglJul4vuIQ0zZd2j7h5VOpEslBuWTo0u8g9h8qU4kmn
         RTGKJDr3SGs94M63JamgclbeRCgFV3RttRyTHtxRIVahW5bxlyk26zyNRsfOQvpOqcfm
         IK7A==
X-Gm-Message-State: APjAAAXbtJR0V5npgZngkuwJu7hZyJSx9VDej49UMFQWJnN5fQCWqC0L
        7Ea+xPr/xNOa+KvDBUu/H2puDzWT
X-Google-Smtp-Source: APXvYqwbcZk333giDfyIBxrL1wYqMAMMIP5P3xL7wlItBAK2l4MYOBQ3UZF8w51bBN6uzeNSsk++zQ==
X-Received: by 2002:a2e:b4f6:: with SMTP id s22mr2849041ljm.218.1579194068636;
        Thu, 16 Jan 2020 09:01:08 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id y25sm10777983lfy.59.2020.01.16.09.01.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2020 09:01:08 -0800 (PST)
Subject: Re: [PATCH v4 10/14] dmaengine: tegra-apb: Keep clock enabled only
 during of DMA transfer
To:     Jon Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200112173006.29863-1-digetx@gmail.com>
 <20200112173006.29863-11-digetx@gmail.com>
 <5ae55a09-a1be-d93b-80f5-6ad3d712cb93@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1555aa32-085b-4817-3c14-450c5a51339e@gmail.com>
Date:   Thu, 16 Jan 2020 20:01:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <5ae55a09-a1be-d93b-80f5-6ad3d712cb93@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

15.01.2020 13:08, Jon Hunter пишет:
> 
> 
> On 12/01/2020 17:30, Dmitry Osipenko wrote:
>> It's a bit impractical to enable hardware's clock at the time of DMA
>> channel's allocation because most of DMA client drivers allocate DMA
>> channel at the time of the driver's probing and thus DMA clock is kept
>> always-enabled in practice, defeating the whole purpose of runtime PM.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/dma/tegra20-apb-dma.c | 43 ++++++++++++++++++++++-------------
>>  1 file changed, 27 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
>> index cc4a9ca20780..b9d8e57eaf54 100644
>> --- a/drivers/dma/tegra20-apb-dma.c
>> +++ b/drivers/dma/tegra20-apb-dma.c
>> @@ -436,6 +436,8 @@ static void tegra_dma_stop(struct tegra_dma_channel *tdc)
>>  		tdc_write(tdc, TEGRA_APBDMA_CHAN_STATUS, status);
>>  	}
>>  	tdc->busy = false;
>> +
>> +	pm_runtime_put(tdc->tdma->dev);
> 
> Is this the right place to call put? Seems that in terminate_all resume
> is called after stop which will access the registers.

Indeed, there is a problem here. Looks like resume/pause should take
get/put the RPM. I'll correct it in v5, thanks.

>>  }
>>  
>>  static void tegra_dma_start(struct tegra_dma_channel *tdc,
>> @@ -500,18 +502,25 @@ static void tegra_dma_configure_for_next(struct tegra_dma_channel *tdc,
>>  	tegra_dma_resume(tdc);
>>  }
>>  
>> -static void tdc_start_head_req(struct tegra_dma_channel *tdc)
>> +static bool tdc_start_head_req(struct tegra_dma_channel *tdc)
>>  {
>>  	struct tegra_dma_sg_req *sg_req;
>> +	int err;
>>  
>>  	if (list_empty(&tdc->pending_sg_req))
>> -		return;
>> +		return false;
>> +
>> +	err = pm_runtime_get_sync(tdc->tdma->dev);
>> +	if (WARN_ON_ONCE(err < 0))
>> +		return false;
>>  
>>  	sg_req = list_first_entry(&tdc->pending_sg_req, typeof(*sg_req), node);
>>  	tegra_dma_start(tdc, sg_req);
>>  	sg_req->configured = true;
>>  	sg_req->words_xferred = 0;
>>  	tdc->busy = true;
>> +
>> +	return true;
>>  }
>>  
>>  static void tdc_configure_next_head_desc(struct tegra_dma_channel *tdc)
>> @@ -615,6 +624,8 @@ static void handle_once_dma_done(struct tegra_dma_channel *tdc,
>>  	}
>>  	list_add_tail(&sgreq->node, &tdc->free_sg_req);
>>  
>> +	pm_runtime_put(tdc->tdma->dev);
>> +
>>  	/* Do not start DMA if it is going to be terminate */
>>  	if (to_terminate || list_empty(&tdc->pending_sg_req))
>>  		return;
>> @@ -730,9 +741,7 @@ static void tegra_dma_issue_pending(struct dma_chan *dc)
>>  		dev_err(tdc2dev(tdc), "No DMA request\n");
>>  		goto end;
>>  	}
>> -	if (!tdc->busy) {
>> -		tdc_start_head_req(tdc);
>> -
>> +	if (!tdc->busy && tdc_start_head_req(tdc)) {
>>  		/* Continuous single mode: Configure next req */
>>  		if (tdc->cyclic) {
>>  			/*
>> @@ -1280,22 +1289,15 @@ tegra_dma_prep_dma_cyclic(struct dma_chan *dc, dma_addr_t buf_addr,
>>  static int tegra_dma_alloc_chan_resources(struct dma_chan *dc)
>>  {
>>  	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
>> -	struct tegra_dma *tdma = tdc->tdma;
>> -	int ret;
>>  
>>  	dma_cookie_init(&tdc->dma_chan);
>>  
>> -	ret = pm_runtime_get_sync(tdma->dev);
>> -	if (ret < 0)
>> -		return ret;
>> -
>>  	return 0;
>>  }
>>  
>>  static void tegra_dma_free_chan_resources(struct dma_chan *dc)
>>  {
>>  	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
>> -	struct tegra_dma *tdma = tdc->tdma;
>>  	struct tegra_dma_desc *dma_desc;
>>  	struct tegra_dma_sg_req *sg_req;
>>  	struct list_head dma_desc_list;
>> @@ -1328,7 +1330,6 @@ static void tegra_dma_free_chan_resources(struct dma_chan *dc)
>>  		list_del(&sg_req->node);
>>  		kfree(sg_req);
>>  	}
>> -	pm_runtime_put(tdma->dev);
>>  
>>  	tdc->slave_id = TEGRA_APBDMA_SLAVE_ID_INVALID;
>>  }
>> @@ -1428,11 +1429,16 @@ static int tegra_dma_probe(struct platform_device *pdev)
>>  
>>  	spin_lock_init(&tdma->global_lock);
>>  
>> +	ret = clk_prepare(tdma->dma_clk);
>> +	if (ret)
>> +		return ret;
>> +
>> +	pm_runtime_irq_safe(&pdev->dev);
>>  	pm_runtime_enable(&pdev->dev);
>>  	if (!pm_runtime_enabled(&pdev->dev)) {
>>  		ret = tegra_dma_runtime_resume(&pdev->dev);
>>  		if (ret)
>> -			return ret;
>> +			goto err_clk_unprepare;
>>  	} else {
>>  		ret = pm_runtime_get_sync(&pdev->dev);
> 
> There is a get here but I don't see a put in probe.

Please see:
https://elixir.bootlin.com/linux/v5.5-rc6/source/drivers/dma/tegra20-apb-dma.c#L1445
