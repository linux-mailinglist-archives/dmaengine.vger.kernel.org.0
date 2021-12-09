Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4171546F5CF
	for <lists+dmaengine@lfdr.de>; Thu,  9 Dec 2021 22:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbhLIVXJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Dec 2021 16:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhLIVXI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 9 Dec 2021 16:23:08 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8896EC061746;
        Thu,  9 Dec 2021 13:19:34 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id d10so14499675lfg.6;
        Thu, 09 Dec 2021 13:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w9NVyA3r1gS0dHQGhaIwt4BqUyoksHzNXKqQm+vkFKw=;
        b=jwRbEoyklu2JLCqR1SMPDJAr7IpOzlLs9QkrICOFL3ztGXNx/oCpBPKK4I2a4guZWq
         mZLCzNgqApguCAFNnEjqvxcDBn8iYd40PeV6agk4OQ4WdvKTFGdnIpXLh723BjueY1Bv
         X6RY/enamdBFCXhVpsiGyp3JTOmsgsqeOVzCbQ1vW2tg0NWfMsJbu1O9p1Jk2F3fYumg
         ULZ/S2m26clxYk+DKKo/eunXZ+e5Dy0XPGydyNrUyIhFm/TAcO0ZTpPq9/ipbiybiSy0
         WaSXkqWpVuhN5wSGwXFREo9/6X2LXt4hOGAMGGfd9Ca2YByneOobW8SgHdr75lS/67te
         7QyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w9NVyA3r1gS0dHQGhaIwt4BqUyoksHzNXKqQm+vkFKw=;
        b=PyzrE5y+Zbioe6FhLYrkcTiJ8oy/GJkb0QQcKF+34Z+QcmbJueakaUY4qQl8b7ZWqp
         PITod4eOcnFYYuH+fq8C/KCjOkWa5N6DxfuOnt6LItk5cxF3KwCAUh8RCuPV1aRUn2CI
         sNrK+oYQJJJWhZReK9mVw2p95BEYGkz9IENW9yHBJDlvV0Ypihp7yv9yz/YpYF5AAAQ5
         5pMeeLZtrnxTLJi/NnHeWEw7JPndwYmMse1pZOi4vZYbgnMxzsbv7d/E2ssE5s5DNOiF
         uzvUEjmVdgWtzjTQygJo8tBKZahz0IL2e9F/I1Y2BWzxM25L/hLQ8z6rJm6zm1OF/tRj
         eXEg==
X-Gm-Message-State: AOAM531ts33McOycXYNebnk5ttCh7TOykz33VHlQIs81qR652Wyopfeo
        ZUDpu2jrd7C9MvpV26hUve0=
X-Google-Smtp-Source: ABdhPJxQCqULlQtELM136fDWzedMTP7IrJZ/S5NS9VmXHVC56VfQeh6sXcNLIF7qxZ4Io+03QXbN5w==
X-Received: by 2002:ac2:5ec6:: with SMTP id d6mr3004349lfq.297.1639084772893;
        Thu, 09 Dec 2021 13:19:32 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id be25sm100371ljb.114.2021.12.09.13.19.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 13:19:32 -0800 (PST)
Subject: Re: [PATCH v14 2/4] dmaengine: tegra: Add tegra gpcdma driver
To:     Akhil R <akhilrajeev@nvidia.com>, dan.j.williams@intel.com,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        jonathanh@nvidia.com, kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        p.zabel@pengutronix.de, rgumasta@nvidia.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, vkoul@kernel.org
Cc:     Pavan Kunapuli <pkunapuli@nvidia.com>
References: <1638795639-3681-1-git-send-email-akhilrajeev@nvidia.com>
 <1638795639-3681-3-git-send-email-akhilrajeev@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <913af84a-957f-6392-1526-6732d43fec5b@gmail.com>
Date:   Fri, 10 Dec 2021 00:19:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1638795639-3681-3-git-send-email-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

06.12.2021 16:00, Akhil R пишет:
> +struct tegra_dma_channel;

This prototype is unuseful.

> +/*
> + * tegra_dma_channel: Channel specific information
> + */
> +struct tegra_dma_channel {

