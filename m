Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931667BF844
	for <lists+dmaengine@lfdr.de>; Tue, 10 Oct 2023 12:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjJJKO4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Oct 2023 06:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjJJKOz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 Oct 2023 06:14:55 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F69594;
        Tue, 10 Oct 2023 03:14:54 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-5031ccf004cso6614282e87.2;
        Tue, 10 Oct 2023 03:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696932892; x=1697537692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=80OpIS40s1vkmwDyLE3ER59Wl9MfL0jV6cnOUDidQys=;
        b=JeMTfH/98TQVLD9ZkDLK0qM80sdicj8LIPVQEzLqFdhf83ovMPv3C9SaS6Hisvyjla
         hWmekI2CCE2lV8bX0opwu/CCzFu4yYBRjExbDCtm9fIUlRLWjglFeaoALXAqaKOgYd6h
         ZQBvdJpKPPDYGfvo0Kbb4IY7g6stH3AII4ERiNSrqLBqk5NEaC1Cg/5qegvF6jGWZ5oC
         RsIOO7euYeRFQNnpS3bhq3iK1yAZVFMfCfYKwWpQr4hEo4b6e1bNtcfWr2bqGFoZPVmf
         WGnDsQ58B+68pu33OcwfQlCCGFXy9IenwDMW6QBDX9ANZLvl+It2is4HTWQILRgsGknp
         Hkiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696932892; x=1697537692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=80OpIS40s1vkmwDyLE3ER59Wl9MfL0jV6cnOUDidQys=;
        b=sE0pqe5l+aAoc+7wNgqmOeYv0qg9oHE0rSaCcGym7V8NvGVMGLNwTAz4SMKxiPKH7P
         XJ6wOLq2uNPbDKzPV7Ug5nHF4Z4vchPJTyhqycVgK3q39llBYehbrrf5X8fQxJ/J2imH
         40AlSWH1/vP1fyX47JFZei/jSuQqkiT3TK53rX8RJRuv7qaOIvYst/EqMS4eE3X5h4gX
         BGy+2te97BLC4J74u8XDu/o5fKGQIO4fAxBCVclMuoClP72O5XaETTxeoJx3CACluPpZ
         2eXFB8vI8KwoN44TPK+iQU26re9ZGW5+bWS23mM/mwnVe5/yZN5YKsKLUBzdI5ptFS25
         /5KA==
X-Gm-Message-State: AOJu0YzT0O99bQHc6xeAcCTAQwzVVmot8147rlOhwsqBC9eg/8lloFV8
        j7Lwl0VyngKRG///Er+vKZxfLIWi8VKiNWvK
X-Google-Smtp-Source: AGHT+IEsjpd2SiY/E8n3p6FFUYdxL18Cv/B3iXtDZdgVK2Y+zvHTWbx6z61SoNb5S3gF3gdCe7WTrg==
X-Received: by 2002:a05:6512:31d0:b0:4ff:a04c:8a5b with SMTP id j16-20020a05651231d000b004ffa04c8a5bmr18443127lfe.47.1696932891753;
        Tue, 10 Oct 2023 03:14:51 -0700 (PDT)
Received: from skhimich.dev.yadro.com ([185.15.172.210])
        by smtp.gmail.com with ESMTPSA id w2-20020ac25d42000000b004fce9e8c390sm1754454lfd.63.2023.10.10.03.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 03:14:51 -0700 (PDT)
From:   Sergey Khimich <serghox@gmail.com>
To:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v2 0/1] Add support DMAX_NUM_CHANNELS > 16
Date:   Tue, 10 Oct 2023 13:14:49 +0300
Message-Id: <20231010101450.2949126-1-serghox@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patch adds support for DW AXI DMA controller with 
32 channels.

v2:
 - Fix warning reported by kernel test robot:
   | Reported-by: kernel test robot <lkp@intel.com>
   | Closes: https://lore.kernel.org/oe-kbuild-all/202310060144.oLP6NoVL-lkp@intel.com/


Sergey Khimich (1):
  dmaengine: dw-axi-dmac: Add support DMAX_NUM_CHANNELS > 16

 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 156 +++++++++++++-----
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |   6 +-
 2 files changed, 120 insertions(+), 42 deletions(-)

-- 
2.30.2

