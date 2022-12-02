Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7A2641045
	for <lists+dmaengine@lfdr.de>; Fri,  2 Dec 2022 22:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234790AbiLBV6K (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Dec 2022 16:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234795AbiLBV6J (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 2 Dec 2022 16:58:09 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EBF60357
        for <dmaengine@vger.kernel.org>; Fri,  2 Dec 2022 13:58:06 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id td2so14492135ejc.5
        for <dmaengine@vger.kernel.org>; Fri, 02 Dec 2022 13:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gigaio-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2JofjhmShzdtfl2UfqjKQ0+vaO1XRxS/EsV7fABlptc=;
        b=RtxslHUy5SU55MCZrJWxZC8pM4W4LYceO2WjCQ7lp90fnS9MQCORDFWtpsTN1HFVPU
         +SmHpACHwFRFCc1SQRbN03eWp4mntKAcB3Ja5TSuabZ/fRzfaVpFeIrszvrzC8WG6Fl4
         1np3kW5QXB4Staoj1V+vL1kxo1d3JCxMLOXHmt4KxQEKYHN4oWoZZ81UwylS6wZaq0a4
         OPXppaVBlrHFBpRD90nOOcP7NlGxX9bv+OYEXn1L7oPaB1wnoqirjuMvi3BbjYgEnUk4
         GE9a4iB3oHTUYmLViAQAcZgKMpAb21x+LAOhixm0b8SfOXD2GhAtaleWwP1ghrYVH6pq
         IBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2JofjhmShzdtfl2UfqjKQ0+vaO1XRxS/EsV7fABlptc=;
        b=m4LvPIjd6NuiTUuHZh/UGVrxbMb6hGdpZL2g1z5dJxY9wtn6I3kwTeNHGzxPNn9PJ2
         DsV0i/3PNmdBZX0Xwpms4MM/vWl0cGoL5o1Vwf2JA16V0+X1XQHTrTrkuvn15p3+HMsJ
         J2Zip8F7dk7M4lncHH8XrqdNHi9nLWQm/gW78VjJWpqdA00mG1VLY0Y6mFffb3Jb7KF/
         EcASDYEjowDPgsLaxpV5743rJdOJp07lJC0hbXfhha3J7VYvggmWXBe7/DrhC2NhB3VJ
         s3q3/O/IGZw8JN8TCuWLNTI1lvEPRCoRZPWkJXWr51Qxkn+swqQC7zUtvXthsQ+9m7RU
         Nc/Q==
X-Gm-Message-State: ANoB5pnOYJ+I5i2CXq7+hGvJP90iSBtQo9qM1wr5JEfh+agIzsNo65Kl
        bP7rldlMOQTtFtnxAiO5m+lpe61cM3I97ElwrLuHtHYD6GdHpQ==
X-Google-Smtp-Source: AA0mqf7Mj2mRsHQMSGiTX7Fyute9HiqE8tOGn0bOmXbpnitsesR/9AWeZItI6Yncc6Zq2IezrNVF66C67Y3cdLNnSGU=
X-Received: by 2002:a17:907:3907:b0:7ae:37a8:9b5c with SMTP id
 so7-20020a170907390700b007ae37a89b5cmr7991822ejc.241.1670018285114; Fri, 02
 Dec 2022 13:58:05 -0800 (PST)
MIME-Version: 1.0
From:   Eric Pilmore <epilmore@gigaio.com>
Date:   Fri, 2 Dec 2022 13:57:54 -0800
Message-ID: <CAOQPn8tHAx1zsgUO7UAuKf1DJYt+fdT6OPAHoxO+HgEPvT5SPg@mail.gmail.com>
Subject: poor ptdma performance
To:     dmaengine@vger.kernel.org
Cc:     Eric Pilmore <epilmore@gigaio.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Was curious if anybody has any expected performance numbers for the
AMD DMA engine "ptdma"?

I'm doing some testing utilizing the "ntb_netdev" module for TCP/IP
communication between servers via NTB (Non-Transparent Bridge) using
"iperf". I find that on Intel based boxes, utilizing IOAT DMA, I can
get approximately 19-20 Gb/s for a simple untuned single iperf
instance. However, when running on AMD based boxes (Milan CPUs), and
running the latest ptdma driver from the Linux tree, I can only
achieve about 2-3 Gb/s. I'm thinking there must be some driver knob
that I need to tweek or something.

Any help is greatly appreciated.

Thanks,
Eric
