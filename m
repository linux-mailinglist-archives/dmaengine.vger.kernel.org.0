Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A117490B98
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jan 2022 16:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240569AbiAQPlI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Jan 2022 10:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237263AbiAQPlH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Jan 2022 10:41:07 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A04C06161C;
        Mon, 17 Jan 2022 07:41:07 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id b14so40653208lff.3;
        Mon, 17 Jan 2022 07:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5y8O1ztdEpf6Q5K1EWJl/cnGkg0Yyb3hjgY54wdHbA0=;
        b=I3TXrgYdSkMgV6jQBIuL4t/kAnifbPfadKQXpiUEwrrRAxPONrQcLu2JvDUN6i2klu
         59mwDxYiJpHqY+At28M2RqrGoGPoBM7YBl3ybzxPupE+Ixm/tAl9qajHJA2zVyTfeed8
         HGbm/NV849yHRyOZND8pn8/bAYoQ/gtbYdeIPylKPcelOG6EYS6f2tT1WoU5LYM30rxk
         F1CPqdocoTn6gd4wtJTO461HV4mTKa7ty7Xku9sqAtX/0TsLpcU+O/12FfKQHqLnGoLm
         UGlE7WZOWgMDp+4bs+i4Auc5hbCvZuqScLC95bdV+igiloV/cxMjrYVA1mD2JckpjRDt
         xR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5y8O1ztdEpf6Q5K1EWJl/cnGkg0Yyb3hjgY54wdHbA0=;
        b=CghkiQEGVdEyfpFppOhHrn7UFVVBdstL1wFG38VoTbfChDGgeUJGV2x4miHMe19kGr
         /sigAJTQ71XPHqJkip/lLQc5MLPlkWqFC2GM4WnFmHEZwgMcuyJwLPIKwwAh1HVE9Ujr
         Qd4tNwlnb3iBUXtwKsiaysgEU/iFWDJ8xb4Nq7lRLH9KL3GBpG+zkUDq/+Sv7jnl6wtl
         GPI3PF550RAVY7DMcLfjoKJ47verlbKlY0cbXth6oFYGv5tZ3zbGbZpgbYu5Gcye/GvJ
         wB1MS942+ptZzXSjKzKLPHzLi74+iBvJyR6wxpc4c1wfUtlEs6adCB4sCdCpZAT1OTAi
         lEMQ==
X-Gm-Message-State: AOAM533nPqBiKUyxF7ZMhvjamxA/RqB1ayEwhuKjq3lxUJqM2F71lSum
        8ZdAOr6HKQWeujZ9LiyJAKQ=
X-Google-Smtp-Source: ABdhPJyWpdQazpzpnwHC6v7uwHKEePYVC80n+PdtMGszQLyxMhWoZygnqF4NdaS4DRX42FzPLBud7Q==
X-Received: by 2002:a2e:95cf:: with SMTP id y15mr15070933ljh.132.1642434065726;
        Mon, 17 Jan 2022 07:41:05 -0800 (PST)
Received: from [192.168.2.145] (46-138-227-157.dynamic.spd-mgts.ru. [46.138.227.157])
        by smtp.googlemail.com with ESMTPSA id w16sm1427526ljh.122.2022.01.17.07.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 07:41:05 -0800 (PST)
Message-ID: <1db14c3d-6a96-96dd-be76-b81b3a48a2b1@gmail.com>
Date:   Mon, 17 Jan 2022 18:41:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v16 2/4] dmaengine: tegra: Add tegra gpcdma driver
Content-Language: en-US
To:     Akhil R <akhilrajeev@nvidia.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Rajesh Gumasta <rgumasta@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>
Cc:     Pavan Kunapuli <pkunapuli@nvidia.com>
References: <1641830718-23650-1-git-send-email-akhilrajeev@nvidia.com>
 <1641830718-23650-3-git-send-email-akhilrajeev@nvidia.com>
 <16c73e83-b990-7d8e-ddfd-7cbbe7e407ea@gmail.com>
 <DM5PR12MB1850A5F5ABA9CD5D04C37086C0579@DM5PR12MB1850.namprd12.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <DM5PR12MB1850A5F5ABA9CD5D04C37086C0579@DM5PR12MB1850.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

17.01.2022 10:02, Akhil R пишет:
>> 10.01.2022 19:05, Akhil R пишет:
>>> +static int tegra_dma_terminate_all(struct dma_chan *dc)
>>> +{
>>> +     struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
>>> +     unsigned long flags;
>>> +     LIST_HEAD(head);
>>> +     int err;
>>> +
>>> +     if (tdc->dma_desc) {
>>
>> Needs locking protection against racing with the interrupt handler.
> tegra_dma_stop_client() waits for the in-flight transfer 
> to complete and prevents any additional transfer to start. 
> Wouldn't it manage the race? Do you see any potential issue there?

You should consider interrupt handler like a process running in a
parallel thread. The interrupt handler sets tdc->dma_desc to NULL, hence
you'll get NULL dereference in tegra_dma_stop_client().
