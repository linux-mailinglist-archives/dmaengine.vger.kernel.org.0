Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355ED4A8B7C
	for <lists+dmaengine@lfdr.de>; Thu,  3 Feb 2022 19:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237251AbiBCSWx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Feb 2022 13:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbiBCSWw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 3 Feb 2022 13:22:52 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678AFC061714;
        Thu,  3 Feb 2022 10:22:52 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id u6so7725370lfm.10;
        Thu, 03 Feb 2022 10:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bng1VAntY/a3MWNMO6+RyoYVA2d8DbBn++5DPIHqtuE=;
        b=oUvg3YIN+C0100TFCoV/mVO86/Yq4luRNsxS6SFksfs2C5x06U7fRzh0nfJCu2979d
         Yo6Cx8hO0BldiQfZQsUOR9xbBocmoaYRNuJ9rCM5YNkLNGFD+2E3uYMiNc8byQixijs7
         DX0uCXEY8A0PRyMIkh9Bq/RBmLlu7w5e5TWv1m7x/G1uAC2iPFedObhXYVN54UCMOwVp
         ZnrZFAoKsG/7Z/1GQU0uLo7o36gqNmMtbgsaGQ6LZuZSlPFW+QmLPWO3tZN1CbcvlW/Z
         xKk4yx1pHU62LGb4FGzUkNQyTk2AeWo5DSYd49sDLdlJO4UhrzAlqxy+JRbc8LHxgS8M
         pZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bng1VAntY/a3MWNMO6+RyoYVA2d8DbBn++5DPIHqtuE=;
        b=Mh3Xu1w77z8CAVhHAgpzOG5SPP5n/cdvMw5tiPLZL2zIg45u9KAJNbRCtQojxuYw23
         w8/YCf7ZOnX4MZG8FuiOH6l3TLjBQ6pC36NPUg3kgv2iVhJ+Ry84Hb+tG5trRNse+74e
         /QVxeqzQUiK5QVyncUEz7KitCAmjVwKUlWIbM0kzNeD5xMks8FzNF4CUUuh+OaRh6hxI
         pH37AZx8NweQZuOppTxpIM7oEJG0Br/lEvajYqOSVhFzbZj/DLXulTqmmE0pFyEbSgSG
         X0GZq6ksFGt1xq8UGeI7cksj9zhhCPTLWNr75sRffiD5hOjiVgxW4TFIpyDgWoZEqlTH
         HI8g==
X-Gm-Message-State: AOAM531XnA3+eWTMSfveJh0MMeHwCZxklTzn1rJQ/HQSD87jgExd2qgG
        aJY+sLPyqPKrmKSpWITk/gg=
X-Google-Smtp-Source: ABdhPJyV14em01gGXmQXgKKTGilU91Wd86iUbuo0lyi5ZsD93O/rCDbCKeIysAnznWdx7ZJ2Ek8c7A==
X-Received: by 2002:ac2:4e08:: with SMTP id e8mr27847098lfr.266.1643912570622;
        Thu, 03 Feb 2022 10:22:50 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.googlemail.com with ESMTPSA id s16sm4319314lfp.197.2022.02.03.10.22.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 10:22:50 -0800 (PST)
Message-ID: <d6d70e52-a984-d973-f3bb-f70f1a4ce95d@gmail.com>
Date:   Thu, 3 Feb 2022 21:22:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v18 2/4] dmaengine: tegra: Add tegra gpcdma driver
Content-Language: en-US
To:     Akhil R <akhilrajeev@nvidia.com>,
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
References: <1643729199-19161-1-git-send-email-akhilrajeev@nvidia.com>
 <1643729199-19161-3-git-send-email-akhilrajeev@nvidia.com>
 <3feaa359-31bb-bb07-75d7-2a39c837a7a2@gmail.com>
 <DM5PR12MB18509939C17ABEB5EEA825FFC0289@DM5PR12MB1850.namprd12.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <DM5PR12MB18509939C17ABEB5EEA825FFC0289@DM5PR12MB1850.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

03.02.2022 06:44, Akhil R пишет:
>> But why do you need to pause at all here and can't use
>> tegra_dma_stop_client() even if pause is supported?
> The recommended method to terminate a transfer in
> between is to pause the channel first and then disable it.
> This is more graceful and stable for the hardware.
> stop_client() is more abrupt, though it does the job.

If there is no real practical difference, then I'd use the common method
only. This will make code cleaner and simpler a tad.
