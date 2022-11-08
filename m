Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBDD62118A
	for <lists+dmaengine@lfdr.de>; Tue,  8 Nov 2022 13:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbiKHMzp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 8 Nov 2022 07:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbiKHMzo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 8 Nov 2022 07:55:44 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573BF13F74
        for <dmaengine@vger.kernel.org>; Tue,  8 Nov 2022 04:55:41 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id p21so14096785plr.7
        for <dmaengine@vger.kernel.org>; Tue, 08 Nov 2022 04:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=Xu3q1wpAFZi5siecx8YJYeMVEiNO3QQV0TxZRQ+DJyt3xesiqjEQF0Rm7HTl3nwOFx
         axFRcyI6i7i6G4/pP2PvVEqbCOsB5kO0Bz5I7GGRrQ5Gw4A4Y5+pCeaCclAgMJGi5sLD
         EqDwDVpkgunNcDGahlfRBuw9Y/t4QzNoq+MJQosb/zVUJD7djXxdETeMvdiX+3iENykj
         /L2SxI+qBvUTceQFCbCgAE/U6X7DwfDOgC1n6cPEToepiM9X2r1bEe3nVe4yS9labuc0
         vSFhNVcwJs6y2ZBANwx+PchOUfyI1hgi5b0wl44pDO48PKbbUM63TL33jEl8pD0dx9Cw
         DrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=FsUTx2sA0pWzIwFo+HVFor15DLprYwseE+jhqR3ZknCrlq/ElwIGYgcdzJm4R2gnwK
         IcL+an3Kp6UgIbbH5tpeEWFgy5wTEa/0As0mbwUGPCwutwx3zaw0jUnjVxg92d3jtc8c
         sLke2OriJ4CYf59DQqtI0V6gDonZos2j6ZVhAtpgVHLRVI7cdz+bP+b31VmxxD+pePdA
         7CFoK+VoA8+tZjaPcz/eRrnrZ5w9zQDiz9IWMOUK4SXJYg3HHzpchrFr0gmqJscbrTSG
         n+BU4UZ0sTg68cCNXr071xvF1/eET+vCWPxvmZVrlsnc6YcUegjjYxXC1NuvFp44VFnK
         u9WA==
X-Gm-Message-State: ACrzQf0qpx1M3bt7x3anP5g92nMiseP4CZ30ddf+Dbk+0Xl5OJrZkgnA
        efpYrOcH7cB/MfXzYSAYPnVtu4ojCcn/0Gxl0c0=
X-Google-Smtp-Source: AMsMyM47LS1qPZzLkwuenKG9e8EkqVAx0b1o0h2FMTeFjb4uVbum8HuMg+fTLdolpE8VrYkkaCtOGqUAWl4+Li1UXi0=
X-Received: by 2002:a17:903:124c:b0:179:da2f:2463 with SMTP id
 u12-20020a170903124c00b00179da2f2463mr55014644plh.128.1667912140584; Tue, 08
 Nov 2022 04:55:40 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a11:c394:b0:352:4c7b:293f with HTTP; Tue, 8 Nov 2022
 04:55:39 -0800 (PST)
Reply-To: mr.abraham022@gmail.com
From:   "Mr.Abraham" <petersina60@gmail.com>
Date:   Tue, 8 Nov 2022 12:55:39 +0000
Message-ID: <CAAxicr_Ht+E1c1=DdHJU221hdcfi0CkGrtNrQpRt0EnGUPsFUA@mail.gmail.com>
Subject: Greeting
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:634 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4987]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mr.abraham022[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [petersina60[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [petersina60[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

My Greeting, Did you receive the letter i sent to you. Please answer me.
Regard, Mr.Abraham
