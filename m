Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1C955CC98
	for <lists+dmaengine@lfdr.de>; Tue,  2 Jul 2019 11:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfGBJZW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 2 Jul 2019 05:25:22 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43396 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfGBJZV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 2 Jul 2019 05:25:21 -0400
Received: by mail-lj1-f193.google.com with SMTP id 16so16094767ljv.10;
        Tue, 02 Jul 2019 02:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e+ERxpd73DxC4MxlVJMnS2JsEkTIzOmmsxfHhHYhUvE=;
        b=kyfd/lNbUDSD4OtSsZRiiSWp/BtuSHOAbUzan0lLdCe6ywHkVdn5JaTskxFiB43DJ2
         zAh1aAGyBrc2tIQ/JTwvbqzvHnL1k+zoakSLCW6i2CEYknA01zhe2CDEalZ07ofRwqFu
         N2q5kHhNLVB7DmdLYI4qOId/kdBCBk4s4+erxGKgc62sfbP6W0i4QIIzmvepdd+ddXWN
         BLWxAIpLW28uq1ozZWPIk8ZLoMSZNhjtflhwHDvPrk5lx9MEb3xCWlZzitvw7m07abJM
         mODKrGcXOqKDKa6abZusAPJ9/G1OWAOZRd9d41+yOC0hqlIU1y6bBAhUG10YjSXP/KEw
         SX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e+ERxpd73DxC4MxlVJMnS2JsEkTIzOmmsxfHhHYhUvE=;
        b=OEX3REdF6h0gsqtvOrDQViiFXByk60YndetgWQcKZYzawzGgKt8NuUiqk1RfaBYCvU
         DRXBAn4Rsy5+VgHKl8/RyhHatdaxj75vY1YGAbdhQN62m1EtPzQ7Lc3AYCKEwA+kLWFG
         WZ+PNNnAqpwUhVgyx+SDtzM2GDDl/zxaSx7Fofhq24H8evqRaEj8AMQVGKhKMS5a8DqN
         AFBziYa4sO0eH2llFw79e52itaXWVe7A5x9x3PIiRYZIsnoCJxFDc1bTSf3rmVwxLfNq
         D9ZO2gt1ZC0IGJanyK8sICuvPheRcFlD9jFk8pYKXza60w/xVj/L+fTWC5MNbYTrDf3A
         5GMQ==
X-Gm-Message-State: APjAAAXzgxLLVhMl0OLi0hbURIts0qB0QjWSsWHDJF2GDGdyAh377goi
        n67sda/1oYZJgRWhw9XI/dScLElk
X-Google-Smtp-Source: APXvYqwaRUH+28spPqlheHxdwf0YCYCv9jTAwmBQawPJVNxOAaS3SGM+VwjAPjeAo3eGKhK8cqldLg==
X-Received: by 2002:a2e:81c4:: with SMTP id s4mr16580310ljg.182.1562059518979;
        Tue, 02 Jul 2019 02:25:18 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id y4sm1374885lfc.56.2019.07.02.02.25.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 02:25:18 -0700 (PDT)
Subject: Re: [PATCH v3] dmaengine: tegra-apb: Support per-burst residue
 granularity
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190627194728.8948-1-digetx@gmail.com>
Message-ID: <8b4fbdb5-c6fa-6481-4894-6c2c77c23195@gmail.com>
Date:   Tue, 2 Jul 2019 12:25:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190627194728.8948-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

27.06.2019 22:47, Dmitry Osipenko пишет:
> Tegra's APB DMA engine updates words counter after each transferred burst
> of data, hence it can report transfer's residual with more fidelity which
> may be required in cases like audio playback. In particular this fixes
> audio stuttering during playback in a chromium web browser. The patch is
> based on the original work that was made by Ben Dooks and a patch from
> downstream kernel. It was tested on Tegra20 and Tegra30 devices.
> 
> Link: https://lore.kernel.org/lkml/20190424162348.23692-1-ben.dooks@codethink.co.uk/
> Link: https://nv-tegra.nvidia.com/gitweb/?p=linux-4.4.git;a=commit;h=c7bba40c6846fbf3eaad35c4472dcc7d8bbc02e5
> Inspired-by: Ben Dooks <ben.dooks@codethink.co.uk>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
> 
> Changelog:
> 
> v3:  Added workaround for a hardware design shortcoming that results
>      in a words counter wraparound before end-of-transfer bit is set
>      in a cyclic mode.
> 
> v2:  Addressed review comments made by Jon Hunter to v1. We won't try
>      to get words count if dma_desc is on free list as it will result
>      in a NULL dereference because this case wasn't handled properly.
> 
>      The residual value is now updated properly, avoiding potential
>      integer overflow by adding the "bytes" to the "bytes_transferred"
>      instead of the subtraction.

Is there still any chance to get this into 5.3? Will be very nice! Jon / Vinod ?

