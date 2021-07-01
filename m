Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3A53B8E12
	for <lists+dmaengine@lfdr.de>; Thu,  1 Jul 2021 09:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbhGAHPt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 1 Jul 2021 03:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234489AbhGAHPt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 1 Jul 2021 03:15:49 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466C6C061756;
        Thu,  1 Jul 2021 00:13:19 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id d16so10017081lfn.3;
        Thu, 01 Jul 2021 00:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wC/1PRe7GxJ7bj3s9B4DAneAO/QGqwh19ucy+kWnhCA=;
        b=ndOvXXVTn2C2JkZz3OFnCn4n4EBES3xtc66LFHjz/NCg4kBuqcuOGJ4t1t4KNL0CEW
         2nKxzGri/rkaRFbqEizsHe7q14CeaFYQD2z/B2z3V6zuPuMSVYK6UVOY3RNyMwDegbHX
         Vn11ipJ2O07rXzbxzJbHHSEkG2y8ZaLWOyzfRnGTV6hz7N0Se7ps1F+AWQFzsXbQXv3k
         8pdblh6aLrnckoryblXxGWRw8gAdcID7sPNoOg/1uG8Pww0uH0EDeXBz8+d6jOnZt0k9
         NxPFOt0193RNFWuQ8AuRQKcNtoDELYm4cwjwZX2QuVdVvBJjX0vXncf+bTTKT8mfF209
         mziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wC/1PRe7GxJ7bj3s9B4DAneAO/QGqwh19ucy+kWnhCA=;
        b=jhWI8hhP1CLecn6Z8axYG2BG6hPJUUtbk8K5FBNuW2ex55ElarS+Zh6VcYWFOL+swG
         phIHx5Mo5vyXRQi1lhqUqbOuyS2RTzovIcIQUdbDaQCKFuFfrYoWrcIejnIC8R06F4iZ
         10/4U7HeselEMqOgS53TO3QkPN5b8RkOPzI2b16Jkkol6sYAwE36jMAkcslZU+97KLFF
         dcHlO+cKkmXoa8TFyCcmGxIMTl3kEaYlK3KyhrNxTiiFEV8fVJTcw5XeSkFLDgEdBeku
         qIeHAOfTC5Xa7DEliru81d41YG+TsEiSlT+35LufNr5NGhOVNSo4Y35GJZwfAfetfZ4z
         S6BQ==
X-Gm-Message-State: AOAM533nrl3Pg/jFKO8jCSE5MCmRk+ViM1M+GwtBXjdzzWa5XCMhrNrY
        C4mGpSzjehcTWI+okhO/mAxrip2uSe3ExBAV
X-Google-Smtp-Source: ABdhPJw5w86wS2OjtaqCQmcrqgJC+BDR4pNsOQLr7pCTLWACRkErm1u69GCrRpMEe7nCaTxWN59v9w==
X-Received: by 2002:a19:484f:: with SMTP id v76mr7190429lfa.469.1625123597425;
        Thu, 01 Jul 2021 00:13:17 -0700 (PDT)
Received: from [10.0.0.40] (91-155-111-71.elisa-laajakaista.fi. [91.155.111.71])
        by smtp.gmail.com with ESMTPSA id x17sm2470993ljx.75.2021.07.01.00.13.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jul 2021 00:13:16 -0700 (PDT)
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210624182449.31164-1-p.yadav@ti.com>
 <6b8662e2-2dd5-b1c4-6bc1-24a69776ffac@gmail.com>
 <20210628105822.ighgnu6ebs5npbv3@ti.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH v3] dmaengine: ti: k3-psil-j721e: Add entry for CSI2RX
Message-ID: <7bd64aaf-8836-6484-3160-f2410c85f8de@gmail.com>
Date:   Thu, 1 Jul 2021 10:13:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210628105822.ighgnu6ebs5npbv3@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 28/06/2021 13:58, Pratyush Yadav wrote:
> On 28/06/21 01:38PM, Péter Ujfalusi wrote:
>>
>>
>> On 24/06/2021 21:24, Pratyush Yadav wrote:
>>> The CSI2RX subsystem uses PSI-L DMA to transfer frames to memory.
>>
>> If we want to be correct:
>> The CSI2RX subsystem in j721e is serviced by UDMA via PSI-L to transfer
>> frames to memory.
>>
>> If you update the commit message you can also add my:
> 
> Ah, I thought you were picking the patch up. Does Vinod pick them up
> instead?

Yes.

> Vinod,
> 
> Can you update the commit message when applying or do you want me to 
> send another re-roll?

I would send v4 if I were you. Maintainers are under heavy load most of
the time.

-- 
Péter
