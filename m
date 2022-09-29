Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF53F5F0168
	for <lists+dmaengine@lfdr.de>; Fri, 30 Sep 2022 01:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiI2Xb2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Sep 2022 19:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiI2Xb1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Sep 2022 19:31:27 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F900148A3B
        for <dmaengine@vger.kernel.org>; Thu, 29 Sep 2022 16:31:25 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id y20so2544570plb.2
        for <dmaengine@vger.kernel.org>; Thu, 29 Sep 2022 16:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date;
        bh=cm9FnswtIkP/gY/RUuimKLHOr9IqMWAMCWJdeBuqp+c=;
        b=IQFje1I7eSHPqIDPeqc9C0cqQn3GH3jHDzDbiJ3x8N3r6xQUWpcDDiPhNJ1uEETcbj
         cejxhv4UF0uLiyFfjVey9wb+m9pO3oD3q6KDpZV7fo96rIRhBDVXCrIzTzmgR/hvcCnr
         JIpoNeWAOtd1Ev/kIfQcOOwVYr5mDyqsirD8D3d7DQwnFW6w1AX0mSzPwVk3KS1Rf2dJ
         2o0Fp3/Yo/EFohV8TY+TeneytUkUwTzIwe3WU9X5lJ18wt3XmdfT1Tc77GFPOy39Na2x
         kp27Sx9CL7a55e8xsrQJgEmZUhr0ZMZ19RYEo8xkB0C6Zsoz5tUkO0WdCKmHB4W1TIS3
         fQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=cm9FnswtIkP/gY/RUuimKLHOr9IqMWAMCWJdeBuqp+c=;
        b=GmO3T7qMVqjTrc1b9Bv89p9yPJPv0CxbV+wWS5OaTP+bkwltlPSIjcc5WzLqp0jR+u
         REp6IFXOdbcL4It9NLhmWUCg3GjrUG8yAfISK4pksBhS1KW7nDZBgVw7/UF2gbabhAY8
         TFTgRZK6QtaVbcluFyHFBfhQuiMF6LIxpXAUnA2vUkOugnOEnvbkA2jPxeqk+k9WvLiZ
         Xdone7mN/apt1PSps2xQm73gVSUgNGQzbhfYad3bEksSr1fPEHy3GUkLb5Nj/Otf2YUM
         JLHFtqk0JcCyK6AnpEhPE5Wg5iMvux+8JAI3TxOU6JBCe9pCg+rcBc3s2tOinyHQPMzB
         B8TQ==
X-Gm-Message-State: ACrzQf3liurS/AkYMBCyTyHpoYdPtdbjJGbr3guU/rZF6/cTp3rAmrzN
        ym+mnbEdKw2ERPP9QndsUhtubIaePbJfyw==
X-Google-Smtp-Source: AMsMyM7sfZ0jK2tNFimwhQToHSMR4vkBmj69vOVvgH2kqO9hTshI7l/wUpl3iTurV3igRKOQZ8v9qg==
X-Received: by 2002:a17:90b:1d87:b0:200:b6e1:7e9f with SMTP id pf7-20020a17090b1d8700b00200b6e17e9fmr6331972pjb.235.1664494284983;
        Thu, 29 Sep 2022 16:31:24 -0700 (PDT)
Received: from localhost ([75.172.140.17])
        by smtp.gmail.com with ESMTPSA id q4-20020a17090311c400b001750361f430sm440956plh.155.2022.09.29.16.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 16:31:24 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        dmaengine@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Nicolas Frayer <nfrayer@baylibre.com>
Subject: Re: [PATCH v2 2/3] dma/ti: convert k3-udma to module
In-Reply-To: <YzVKv8zJDU0Sm0Iu@matsya>
References: <20220927230804.4085579-1-khilman@baylibre.com>
 <20220927230804.4085579-3-khilman@baylibre.com> <YzVKv8zJDU0Sm0Iu@matsya>
Date:   Thu, 29 Sep 2022 16:31:23 -0700
Message-ID: <7hbkqxwyes.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

Vinod Koul <vkoul@kernel.org> writes:

> On 27-09-22, 16:08, Kevin Hilman wrote:
>> Currently k3-udma driver is built as separate platform drivers with a
>> shared probe and identical code path, just differnet platform data.
>> 
>> To enable to build as module, convert the separate platform driver
>> into a single module_platform_driver with the data selection done via
>> compatible string and of_match.  The separate of_match tables are also
>> combined into a single table to avoid the multiple calls to
>> of_match_node()
>> 
>> Since all modern TI platforms using this are DT enabled, the removal
>> of separate platform_drivers shoul should nave no functional change.
>
> drop extra shoul
>
> Please change subsystem tag to dmaengine: ti: xxxx for this and next
> patch

OK.

>> 
>> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
>> Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>                                                                                                                            
>
> this has trailing whitespaces, maybe copy paste error

Yup.  Thanks for the review.  Will respin.

Kevin
