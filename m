Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7CD4A35AB
	for <lists+dmaengine@lfdr.de>; Sun, 30 Jan 2022 11:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243397AbiA3K0v (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 30 Jan 2022 05:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbiA3K0u (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 30 Jan 2022 05:26:50 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E90DC061714;
        Sun, 30 Jan 2022 02:26:50 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id q127so15437550ljq.2;
        Sun, 30 Jan 2022 02:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=PinDelor3CufXvK8+aHhSagfHiFVPHlh3AHqb50TDWs=;
        b=CR/a4sqPo1ZDp3cFtzWkYcz5JYNrS9kEfWCsIkVssgX/r6S7aiSmUHMk5h1ZYae3Wp
         +mF4FM3eMny4Cr0OlCIHY9k14jOmVvzqSTQzUtvV4XUaFi+G/jaWmutvx3MYbZtVLSUw
         zxBTT+UYZ7fhZA4J3CyQ4pBmC7R+YTf8xHxnOkijOZfiBcGdwKzyW4UE1Ivx0612gVC/
         HqdoD6CLEYSV6eZ6UCG5bXauYg47rkqOxszNj2+TeRbw80fu45OjaucdcHmQxYIBgbrn
         N0LdmSftUtaqTAg/qdisP1YDSh7h/mNOwV7FBlGNNZ1rFmtRsTvYQdf9RIGkny2MvBEH
         sweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=PinDelor3CufXvK8+aHhSagfHiFVPHlh3AHqb50TDWs=;
        b=3+KM/Fa1WAfH6jxPEMGVljGLwJZWiWPmIFmBh4Yd9n49qt/+Otq5gL8S9YaSFb3Vov
         liTEJaRjOhmIg4dyoov+OsBXAmiyAQeIkoCcVOCtiO+9e8f+V24Y61/UkefjFczHjUaw
         biGeU9QgM8I1WKamcXgp8XHYeHN7vtM9G14w9cH+g6Vt38YNy26DKCmf2PcQG/Q8uxCN
         pWd9f+bnN6EpQIz/t+gZcr1xTKX9qj0/DcRv8yGiR97GjtlPiUVTpiaoIAp4wHUeQ5nl
         oru7V4tW8ODkBYwMbHawR87B7VY9MbO3CN6Lu0Es+gcE1vNGvxVLQjs+jR5YfQqDgzWd
         gbgg==
X-Gm-Message-State: AOAM530E7AhrbQNWuBXmybXOARuv8JjHSzJc7Nq83qHZccGudjcD/CYt
        GiC+pcqj5GiFsO9HdS50GTtZXpZ8Izs=
X-Google-Smtp-Source: ABdhPJwhAlPDwTu7+tYsnT42KCytF1fr77kMg+Tc3OK1jBl2LXSEJhu+0E5YVL2itdZxTO002BGXNw==
X-Received: by 2002:a05:651c:a0f:: with SMTP id k15mr8433823ljq.68.1643538408186;
        Sun, 30 Jan 2022 02:26:48 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-126.dynamic.spd-mgts.ru. [109.252.138.126])
        by smtp.googlemail.com with ESMTPSA id m12sm3217332lfj.90.2022.01.30.02.26.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jan 2022 02:26:47 -0800 (PST)
Message-ID: <dcd4e4db-2999-15c9-0c82-42dd8ca1e61d@gmail.com>
Date:   Sun, 30 Jan 2022 13:26:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v17 2/4] dmaengine: tegra: Add tegra gpcdma driver
Content-Language: en-US
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Akhil R <akhilrajeev@nvidia.com>, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, jonathanh@nvidia.com,
        kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        p.zabel@pengutronix.de, rgumasta@nvidia.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, vkoul@kernel.org
Cc:     Pavan Kunapuli <pkunapuli@nvidia.com>
References: <1643474453-32619-1-git-send-email-akhilrajeev@nvidia.com>
 <1643474453-32619-3-git-send-email-akhilrajeev@nvidia.com>
 <ba109465-d7ee-09cb-775b-9b702a3910b0@gmail.com>
In-Reply-To: <ba109465-d7ee-09cb-775b-9b702a3910b0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

30.01.2022 13:05, Dmitry Osipenko пишет:
> Still nothing prevents interrupt handler to fire during the pause.
> 
> What you actually need to do is to disable/enable interrupt. This will
> prevent the interrupt racing and then pause/resume may look like this:

Although, seems this won't work, unfortunately. I see now that
device_pause() doesn't have might_sleep().

