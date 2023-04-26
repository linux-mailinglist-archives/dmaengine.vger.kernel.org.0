Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D466EFC3A
	for <lists+dmaengine@lfdr.de>; Wed, 26 Apr 2023 23:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239021AbjDZVLn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 26 Apr 2023 17:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbjDZVLm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 26 Apr 2023 17:11:42 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593FE83
        for <dmaengine@vger.kernel.org>; Wed, 26 Apr 2023 14:11:41 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-94eff00bcdaso1409984066b.1
        for <dmaengine@vger.kernel.org>; Wed, 26 Apr 2023 14:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682543500; x=1685135500;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JL3yT3Q33W5/BCQtgOVvz2cK4S2v0dqNTi6RS5aes9g=;
        b=lCn12SGIxvqCukkslyDC40i4Uxj3DJdjkEmR0yjo/K7TVd56iUZv2GQ7GOMKuviqPr
         WSS2+/EDKrMjGLtDTCAKxcnP0wdrX0A+88byClElgpdFS/UjLwAJVQnZqkLV5/ruH3PI
         EerRlvWa6FyKmwKDda27MJiSJu8aF9e2yYppO459oT38AUn7+Kzg4GZhFkUlDGvzt69A
         cLfP0FzVgjX4cSaGPxudW27piLFPRWvBJdNiH+8AqcHt6yTCHcyv0rzpi4KSkZMckIDZ
         kkdzbKJRKqz0p3kj6N1BKAP8WcI8aMoGjhauXnewigmXC5V2UI8Skb474cfq77Sx3hNy
         fXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682543500; x=1685135500;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JL3yT3Q33W5/BCQtgOVvz2cK4S2v0dqNTi6RS5aes9g=;
        b=E75nSqVivn+QroNzGaeUyTlJ1PTj6vG00OI+MsAFbmXvHqVXrcPcztPMhNrkJ2kDwC
         eVIngAAUVyzZGOZOhrwAl1TgFt+jRL2g3mc/+4KvyPHUf0c61hiNG+bFrCB+h82BRfFs
         SWKOWU00JdQaqtCX0Y3nGhqkcr9bYKrF049IoHfN/sBICg9aDT2G/PEy16/jWD3IVycR
         jUzJMZGUmjSixKzdzYBuCnrJF3h9lzifckGzTE29B31suPKlcfAqJp6kfAg7XhDmOai3
         qEjanht2SX7scNqOn3Y+8BNXxto2eWZFpZlZ6FSRRknXumE+mOUu8OznTDmZgAYy7i1v
         KHEQ==
X-Gm-Message-State: AAQBX9fw/RYJMMS7lxTV5gEt420fnV3KdK9Ioh+TZXt4XlDB9auzYiJ8
        P4AgrjOVu465XgvfkcIVjmnb5raN94cxqxzl3qE=
X-Google-Smtp-Source: AKy350brwlz1k7bPy8IriosaEbcyveJ8Qw75IhsNxiGzUkuNCIsP1p3eBKnGo6mE5LbJ3pNew7M9b1cbPHeQN3+HfMo=
X-Received: by 2002:a17:906:a101:b0:94f:558b:ed7f with SMTP id
 t1-20020a170906a10100b0094f558bed7fmr17917041ejy.18.1682543499652; Wed, 26
 Apr 2023 14:11:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7412:4783:b0:c6:d649:3a3a with HTTP; Wed, 26 Apr 2023
 14:11:39 -0700 (PDT)
Reply-To: klassoumark@gmail.com
From:   Mark Klassou <jamesjanneth27@gmail.com>
Date:   Wed, 26 Apr 2023 21:11:39 +0000
Message-ID: <CADCRY1dHtutZtwQJXk5FcZQnQPw3a+FXsumsF8ycUU5kcFwoPg@mail.gmail.com>
Subject: Re
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.9 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Good Morning,

I was only wondering if you got my previous email? I have been trying
to reach you by email. Kindly get back to me swiftly, it is very
important.

Yours faithfully
Mark Klassou.
