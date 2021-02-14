Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21FE831B07F
	for <lists+dmaengine@lfdr.de>; Sun, 14 Feb 2021 14:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhBNNWl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 14 Feb 2021 08:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhBNNWk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 14 Feb 2021 08:22:40 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CD1C061574;
        Sun, 14 Feb 2021 05:21:58 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id cv23so2178559pjb.5;
        Sun, 14 Feb 2021 05:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c7vnThlFNmoIJdJgKrHEtOilK3UWuZ4n3yCmFNBMnKk=;
        b=pniJVmeckDTgoxSo/kcK9iz1YxQfGFVJj/Q7JdnIvMGBJOgS/S1hgsoYO3WSrEzmid
         3K0HG8+5ckzIrS9OYeW7/37yFSt3rScpNuivGUqzACgEaKNYJ7woa3ad419qGl72WHak
         mUHAQinVl2ZvhtVj5EaTTvmBkrfihwgjY+szVmXWh2EfqL8z6RUtdOoE+TvEJLb3N4Oe
         dOiyR+acZJF3edXFHgYjshCq7catwI+2dbJMFbxpOHnG1LVgFoBbPKazL1I1B5vzua1S
         qCBdy3lOsVvRaSsE6p2spkQwfsHM1DvmYpB/yg4U+SV8tDPgSAGKt4SJZoo0c8v5ZTiR
         j5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c7vnThlFNmoIJdJgKrHEtOilK3UWuZ4n3yCmFNBMnKk=;
        b=Jpk5uf8fWtce8DIhkHPROJNQv4gonxiSZqT0/ETUx/J7/VuPe/LuflFuNdniyYVSWY
         e31OQcA0M6hX148Khrm9DRXAWhuoJoNDSXaWfSrIYaJrVyX5MAXVPPTru7uSv23Y2Wrp
         pdGdxnhJNrkogTInwKk+WgEpL2Pqh14FMeGrmQjt0pwcxulTWRFe6pQCac0riaHk2fIr
         U0O6lDRUEBgz5ny5xl/zZP0Pl7DlbJosAiIz0PIyT/xd8Fd2L3nIMUy0+wrDigb6mtYB
         8w5+gzBC2rF2lOv+GUnVYE/efluEC6z1awhNZbXShhsw+fXOEswiIHqmrTebQVVQy2O/
         T1SQ==
X-Gm-Message-State: AOAM530FKkDEUwswNtUTYOHwViovm+6hk0dDM+EwRP4/eGhH5FT4/KQt
        TQ47yXD1oGiKGBI1UUvxUq7dXX6W9HGpSw==
X-Google-Smtp-Source: ABdhPJzQEoflPmTYpJtHzNqnRdejfz3IpOYp5sbqkR04MlRuUQkMVlbho4AbEkAppKpPQQlOEKGLhA==
X-Received: by 2002:a17:902:cecc:b029:e1:268e:2286 with SMTP id d12-20020a170902ceccb02900e1268e2286mr11325308plg.62.1613308918536;
        Sun, 14 Feb 2021 05:21:58 -0800 (PST)
Received: from localhost (185.212.56.4.16clouds.com. [185.212.56.4])
        by smtp.gmail.com with ESMTPSA id u142sm13784497pfc.37.2021.02.14.05.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 05:21:58 -0800 (PST)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     gustavo.pimentel@synopsys.com, vkoul@kernel.org,
        wangzhou1@hisilicon.com, ftoth@exalondelft.nl,
        andy.shevchenko@gmail.com, qiuzhenfa@hisilicon.com,
        dmaengine@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH 0/3] Add missing call to 'pci_free_irq_vectors()'
Date:   Sun, 14 Feb 2021 21:21:50 +0800
Message-Id: <20210214132153.575350-1-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patchset just for add missing call to 'pci_free_irq_vectors()' in
the error handling path of the probe function, or in the remove function.

Dejin Zheng (3):
  dmaengine: hsu: Add missing call to 'pci_free_irq_vectors()' in probe
    and remove functions
  dmaengine: dw-edma: Add missing call to 'pci_free_irq_vectors()' in
    probe function
  dmaengine: hisilicon: Add missing call to 'pci_free_irq_vectors()' in
    probe function

 drivers/dma/dw-edma/dw-edma-pcie.c | 15 +++++++++++----
 drivers/dma/hisi_dma.c             | 14 ++++++++++----
 drivers/dma/hsu/pci.c              |  5 ++++-
 3 files changed, 25 insertions(+), 9 deletions(-)

-- 
2.25.0

