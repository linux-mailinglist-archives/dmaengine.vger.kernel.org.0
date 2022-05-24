Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32181532CAA
	for <lists+dmaengine@lfdr.de>; Tue, 24 May 2022 16:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237638AbiEXOz5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 May 2022 10:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238473AbiEXOz4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 24 May 2022 10:55:56 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59D39C2F0;
        Tue, 24 May 2022 07:55:55 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id s23so18546215iog.13;
        Tue, 24 May 2022 07:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mrJ9O+B95vO2kSLRUxqDzigRuRV4KXloCUh2OONa5do=;
        b=XQF0cB4pQ/W3Bh/C+ohjgtL+X8sDEOsKgZpJIAG45R5siVH9dweE1KwvrDCpkyVUaS
         4txYvNfottxhXw3C/BNj3eYc1PI3n9ez5U1dtgapUGGGyHa67SfDngkwywnZWsJ9551e
         BxH0sBwjBJV+Sro0Lv7/yjwPFsC5GPq8EaosAFouj42LGn+Pk2GNSebInnSBoeBEsut3
         JWA5gwm6xm4JnKTl28yAxjoNyE2miHDsIikDKC7EtDHapUc+uIW6CAQig9ebug2ymZB0
         JY1t6PY6qjzRFaqqAoau+r/QF5PLKqS2QSXBgp5AH2tZp3pPxy6CKOKDlD3USSK9fB/D
         5j/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mrJ9O+B95vO2kSLRUxqDzigRuRV4KXloCUh2OONa5do=;
        b=7Fa3Ue8tVlBP+xAdeyQ2UUb6ri4NI4wxaAo+KtFD9Q0xAsihR2ExXFaTjHCagw5OBs
         5vfT2q4pnpllBhNBbyywoV0KSr1u35iPtR4vyd3/EnWznGtEbGM81/yPQt2pV1KXZFGX
         yR+qnYQBTXWlW33SqpCm8EnvnFOgarmekx9vccYKExWTus24m8iwkGxtSkkTqhKW1PBw
         Wilja79Efx4x5jvn9SVwOttmkogrmxN1gDUbdRYhz85CMWkXbh9eeOVw120FUmHxz0il
         QRAU61pgh5BC4Ulkb+FdRWRHOL0hyQMLxlUidrVHKizejStjBxzJb2jkmb+avcbxQFM2
         b/EA==
X-Gm-Message-State: AOAM532O4380fZohN8o0erXW8HK+hwzySm15dwPImUbAqR+c2bovSSFe
        RWuNuOnXp0EbAHE32hbKFf0=
X-Google-Smtp-Source: ABdhPJyeIhKTaluzXqzFpMAagRHk5c7f6fLgzJwOYv9TRT1bOTP4PRvaaPuJtDyK7ZZhM69/ApY5zg==
X-Received: by 2002:a02:904d:0:b0:32b:f02e:4046 with SMTP id y13-20020a02904d000000b0032bf02e4046mr13798486jaf.44.1653404155118;
        Tue, 24 May 2022 07:55:55 -0700 (PDT)
Received: from localhost.localdomain (wnpgmb0311w-ds01-56-195.dynamic.bellmts.net. [142.160.56.195])
        by smtp.gmail.com with ESMTPSA id y20-20020a02a394000000b0032eb25cd33csm2471184jak.78.2022.05.24.07.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 07:55:54 -0700 (PDT)
From:   jassisinghbrar@gmail.com
To:     Hector Martin <marcan@marcan.st>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Anup Patel <anup.patel@broadcom.com>,
        Vinod Koul <vkoul@kernel.org>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mun Yew Tham <mun.yew.tham@intel.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 0/7] mailbox: apple: peek_data cleanup and implementation
Date:   Tue, 24 May 2022 09:55:40 -0500
Message-Id: <20220524145540.363553-1-jassisinghbrar@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220502090225.26478-1-marcan@marcan.st>
References: <20220502090225.26478-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Jassi Brar <jassisinghbrar@gmail.com>


Hi,

> The mailbox API has a `peek_data` operation. Its intent and
> documentation is rather ambiguous; at first glance and based on the
> name, it seems like it should only check for whether data is currently
> pending in the controller, without actually delivering it to the
> consumer. However, this interpretation is not useful for anything: the
> function can be called from atomic context, but without a way to
> actually *poll* for data from atomic context, there is no use in just
> checking for whether data is available.
>
Not exactly... the 'peek_data' is a means for client driver to hint the
controller driver that some data might have arrived (for controllers that
don't have anything like RX-Irq). The controller is then expected to dispatch
data after "not necessarily atomic" read.

  For example, a quick look at some bit may tell there is data available,
but actually reading the data from buffer may be non-atomic.
  In your case, you could already implement the patch-7/7 by simply calling it
peek_data() instead of poll_data(). Its ok to call mbox_chan_received_data()
from peek_data() because your data-read can be atomic.

Also some platforms may not have users of peek_data upstream (yet), so
simply weeding them out may not be right.

thanks.
