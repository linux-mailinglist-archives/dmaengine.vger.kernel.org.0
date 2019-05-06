Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE2114545
	for <lists+dmaengine@lfdr.de>; Mon,  6 May 2019 09:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbfEFH2v (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 May 2019 03:28:51 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41741 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfEFH2v (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 May 2019 03:28:51 -0400
Received: by mail-pl1-f196.google.com with SMTP id d9so5920995pls.8
        for <dmaengine@vger.kernel.org>; Mon, 06 May 2019 00:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=uO8z0Q76r90ztpTNNYiqnBG594TWJeNUgA2Rk2VCNfI=;
        b=wc9PL3IBYBHKoAWxtEj0jE0C4U/0p/5wSuzqodmousiv5aM2dRwn3CMyCqCS2/29Ws
         c3JfmQiXdrAWpHEQyalb1Gpky9RyM4yJ/9lO5Tg/2aiHfoVhCYg34euPc2Mou/5P/0eg
         5MXy1oUUiuMHpxMjgydcS54TfLJIvncbJpz7CzUv9FHc2LYaDOTnt/xpI/HIjyESx4IP
         +YGcBhhsq5gU6M0V1nBS7z+pieA5Mkd6w7GeNJ+HxQ2QwUR/iSdf9STy3vqc8HD8YClO
         lBTRQMh2iDu+WsjIgdqAhgTB0mkdzJh5CA29TD2hChMg50kbS7TmNoa2pyFW63A6Kius
         JrfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uO8z0Q76r90ztpTNNYiqnBG594TWJeNUgA2Rk2VCNfI=;
        b=jTwOKbFBL9w8zqOVEaAZKfgVCsUQpDdlbp4ldtB7Snd/ekIapDMQ4HxECSErf4Ajp6
         w+x2RPrwgf8IJcbKOLGKkjJdzN//5jwJ5VWp1s9kraGr1O8W5voNDz3AYrS55oqOLVKu
         mfFshWn5zpWcJpxWfd4Npl4dwwjaGOwWph6bob3xebWsOo0rQMXYSl5SK4cRX2l7g+IG
         WZQr4JyMygXb6BHCYbAYoNC3dixPC3XjdtpO5qIjG8H+r4KVnl8s2/LcHmB+4rcixZ2G
         u9IpRu19cs/yNolZeDvdtVKApCGYird3Wl5iBjMm+QLIcmKIw/4BK03YPtpqJ5wgkduV
         BR2w==
X-Gm-Message-State: APjAAAUS4TQ+ZlJ0NtBJLGJKC9NeBM5Ejs7piewKX8cvKWTH7wEuWvu9
        lDwkBe6lfrPOKF+w7koK2Zoxrg==
X-Google-Smtp-Source: APXvYqxQA3rQf0P/U8sytSS8uiQkV2XwgMo2mG6tCwPoYvRQAchPZElFMHNUuTpZEiWqGlTb0CsaQw==
X-Received: by 2002:a17:902:1c7:: with SMTP id b65mr29826248plb.2.1557127729646;
        Mon, 06 May 2019 00:28:49 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id w38sm21700894pgk.90.2019.05.06.00.28.46
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 May 2019 00:28:48 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     eric.long@unisoc.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        vincent.guittot@linaro.org, baolin.wang@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] Fix some bugs and add new feature for Spreadtrum DMA engine
Date:   Mon,  6 May 2019 15:28:27 +0800
Message-Id: <cover.1557127239.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

This patch set fixes some DMA engine bugs and adds interrupt support
for 2-stage transfer.

Changes from v1:
 - Improve the commit message for patch 1.
 - Drop patch 4 from the v1 patch set, and I will create another patch
 set to move the fix to the core.

Baolin Wang (3):
  dmaengine: sprd: Fix the possible crash when getting descriptor
    status
  dmaengine: sprd: Add validation of current descriptor in irq handler
  dmaengine: sprd: Add interrupt support for 2-stage transfer

Eric Long (3):
  dmaengine: sprd: Fix the incorrect start for 2-stage destination
    channels
  dmaengine: sprd: Fix block length overflow
  dmaengine: sprd: Fix the right place to configure 2-stage transfer

 drivers/dma/sprd-dma.c |   49 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 38 insertions(+), 11 deletions(-)

-- 
1.7.9.5

