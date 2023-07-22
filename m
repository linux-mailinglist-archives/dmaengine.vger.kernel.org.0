Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9985775DE05
	for <lists+dmaengine@lfdr.de>; Sat, 22 Jul 2023 20:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjGVSIR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 22 Jul 2023 14:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjGVSIQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 22 Jul 2023 14:08:16 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14652D45
        for <dmaengine@vger.kernel.org>; Sat, 22 Jul 2023 11:08:10 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-98df3dea907so465785266b.3
        for <dmaengine@vger.kernel.org>; Sat, 22 Jul 2023 11:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690049289; x=1690654089;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XwQ9KTk0AvNg4YEGpLO6Mzd1tQ0NGTk2GH4qBYSzWYc=;
        b=CJDyVkqHNb3HtbkQ5Lf/+57dSKj94z9wFVHEQ4J81+7UiUAxlu47rNC38ta/OcaYnk
         2Xdv5xIuDOVyvBhCEMgDr8UAzKrvUJCSBv6cpUrgpea74RGmQ0MnukXuitEodR9yjy2w
         /dnJq8kgu6iCS1lNGjhG5AqMEbRb2Nc0QRe7KE3YE9Ahunhct3pn8P/WgWe1KEARtCo+
         y6kwD2eTUMDA9eG2rLFFLwe9SPn/bDHpKcwrZhTpx9c91RteTq4Dio+lbrcBscjwFq3/
         4gVQdQuBkSb+2Tk0GndEYfPwDyyh1kHsLsvjqaKb5DPRAun/gjgE98IB3er/pJMGE4ii
         TeGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690049289; x=1690654089;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XwQ9KTk0AvNg4YEGpLO6Mzd1tQ0NGTk2GH4qBYSzWYc=;
        b=DZwZ3MOMIWH38DOvG0VyHxRPCgQQfM7Acx9a8au6S6kZ6VvhT39gqUvNFSvmj3p39Q
         IAyHXMT1oRESQ24rAHfXbW1ab37G/4WQUz71SO6tnQuBP0PZJgyBmdzl6xFgOw5KWi1v
         xoditJ0deZYevXBe6JwHvrRDReZXrbadI1oqt/ST2rO9VkFJEbMlY+lv+m8N2a012D3P
         FxXYNhNXW308VlYY4zv9XKAAOhip/IP0iZs9j1Y1DGM/fyQpXy0a61s0joLwaJ0kXoSV
         RoLnqWHiOM8Wa/mlc9zuWWQ/eHuxSfEgnX5fvuDHlNG2r/Evf68hfm+cPscF2bfeXPlT
         Vlzw==
X-Gm-Message-State: ABy/qLZ2YRVJQ+vMFbtItYToOzHJRAuvhnsOm6HYPnPvJdRBcamhDsGg
        3dMRKdKfrIud2JU4L+GKz30kLJ08Z1kvXkg88nQ=
X-Google-Smtp-Source: APBJJlE7rlGInlok1k+1KeCbD24At6gAE+ANQdGxY3y76tiQFbUBao3muPGl3DlQ5h1nlt56J4YfPhfYld5FacMUAok=
X-Received: by 2002:a17:907:78d5:b0:98d:e605:2bce with SMTP id
 kv21-20020a17090778d500b0098de6052bcemr4931479ejc.46.1690049289026; Sat, 22
 Jul 2023 11:08:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:907:2cc3:b0:986:545c:2dc8 with HTTP; Sat, 22 Jul 2023
 11:08:08 -0700 (PDT)
Reply-To: mrsvl06@gmail.com
From:   Veronica Lee <msv.willy00@gmail.com>
Date:   Sat, 22 Jul 2023 20:08:08 +0200
Message-ID: <CAL7S737DtLLCzHpLGTQhY5T=uYoMQ+5JmKaZZVw9K6JV6XmY3A@mail.gmail.com>
Subject: re
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

16nXnNeV150g15nXp9eZ16jXmSwg15DXoNeZINek15XXoNeUINeQ15zXmdeaINec157XmdeT16Ig
16nXkdeo16bXldeg15kg15zXl9ec15XXpyDXkNeZ16rXmiDXkNecINeq15TXodehINec15TXqdeZ
15Eg15zXpNeo15jXmdedDQo=
