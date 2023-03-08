Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2B36B0C0A
	for <lists+dmaengine@lfdr.de>; Wed,  8 Mar 2023 16:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjCHPCF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Mar 2023 10:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjCHPCB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 8 Mar 2023 10:02:01 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D7080922
        for <dmaengine@vger.kernel.org>; Wed,  8 Mar 2023 07:01:56 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id p23-20020a05600c1d9700b003ead4835046so2345129wms.0
        for <dmaengine@vger.kernel.org>; Wed, 08 Mar 2023 07:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678287715;
        h=content-transfer-encoding:subject:to:mime-version:from:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=km8AYClsgRL+l4X0k1bSrfqh+593Y4aFlyz7FmefBDA=;
        b=DMh7NP8G9/3Q5Df8p+ADyNWugXmRBkdXUzDO+awmqcJ3zGkWs1fTTQQ+nMAp2jONEj
         4NKQ7d4ts4zjNN3vqu/cHbwA4jAI1N+9L1g0dbcUKOoR0kYjSaXRDcVnFavy4e91kw+a
         F95TbGb2ZzUY37NPk2h1z4T85xmbXamWnuV6FYi8ZwqSlae+vTFLwxzAFhgYKe40i6hV
         Yyf9cBgPX1PoCE0B1SZJtJD4jXUtZDqx1u0aYiNBabqoVXtX8Hf3nCaZ8miCtCl8G3Rb
         bF7TftapaIhWr5ruvp9CeDmgkr/TR2jKAb7G2nQ310hno0hvRJMLdYvafC/8C3a6od4r
         5NCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678287715;
        h=content-transfer-encoding:subject:to:mime-version:from:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=km8AYClsgRL+l4X0k1bSrfqh+593Y4aFlyz7FmefBDA=;
        b=0V7k3OP/M9Yln8Ie5vvy6xc9dAX28NEMJYSp2XpCkaXC0CNQW8yZQFJvaLIfiVkcfD
         /QS98MGyBV+bwTrqRhfR/FbRxUin9wrz70VvGyns2BptYZk2LOrM3x2j0FXUE/7NW2+Q
         pErPNQzHPsZJtfhSNLhTQvlr/5TbLmg27+pr9nyp7CgIKYXtN88B3G75oE6WfsVLHtJo
         G/UGKiTFvIiB2ingvqWoLDShT7qgeVPm8oqEBwCJR1oa9LU5XlFV5ejrCcccAk7UXbmz
         6p7cmX2PAS6WpDdNltXwfMUgmO0mUHjJBgpudvSoGwjDxCXF8EvvePYER500BztEalJ4
         NDIg==
X-Gm-Message-State: AO0yUKVqcrUA/OI6Vbj9SUFzgjZjtq2F4oA6Cm9SdMgNKJlZQfOOvV13
        0xQottIkVY22Nl/ia9dj45iwP4LT8Bs=
X-Google-Smtp-Source: AK7set+IkntFrSxDI2MYvpgzQ71m0RtoA4eAVbMlNJvZ6zQbKIwxV5v3zKPJKg+ECkPuIxcM9WjepA==
X-Received: by 2002:a05:600c:1c05:b0:3ea:f132:63d8 with SMTP id j5-20020a05600c1c0500b003eaf13263d8mr15775427wms.5.1678287715271;
        Wed, 08 Mar 2023 07:01:55 -0800 (PST)
Received: from DESKTOP-8VK398V ([125.62.90.127])
        by smtp.gmail.com with ESMTPSA id p14-20020a05600c468e00b003eb369abd92sm22062795wmo.2.2023.03.08.07.01.54
        for <dmaengine@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 08 Mar 2023 07:01:55 -0800 (PST)
Message-ID: <6408a363.050a0220.dd59c.4d46@mx.google.com>
Date:   Wed, 08 Mar 2023 07:01:55 -0800 (PST)
X-Google-Original-Date: 8 Mar 2023 20:01:54 +0500
From:   amosjace274@gmail.com
X-Google-Original-From: AmosJace274@gmail.com
MIME-Version: 1.0
To:     dmaengine@vger.kernel.org
Subject: Bid Estimate
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello,=0D=0A=0D=0AWe provide accurate material take-offs and cost=
 estimates at low cost and with fast turnaround. Our team of prof=
essionals has been providing these services to General Contractor=
s, Subs (Painting, Electrical, Plumbing, Roofing, Drywall, Tile a=
nd Framing etc.). We offer both Residential and Commercial Estima=
tes and we cover every trade that you wish to bid, whether you wo=
rk with CSI Divisions or your unique classification. We use the l=
atest estimating software backed up by professionals with over a =
decade of experience.=0D=0A=0D=0AWe are giving almost 25% Discoun=
t on the first estimate.=0D=0A=0D=0APlease send us the plans or l=
inks to any FTP site so that we can review the plans and submit y=
ou a very economical quote.=0D=0A=0D=0ABest Regards.=0D=0A Amos j=
ace=0D=0AMarketing Manager=0D=0ACrown Estimation, LLC=0D=0A

