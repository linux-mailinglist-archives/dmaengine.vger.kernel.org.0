Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FAA605989
	for <lists+dmaengine@lfdr.de>; Thu, 20 Oct 2022 10:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiJTIVo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Oct 2022 04:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiJTIVn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 Oct 2022 04:21:43 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49435157F55;
        Thu, 20 Oct 2022 01:21:42 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id f11so33106847wrm.6;
        Thu, 20 Oct 2022 01:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QeezRGYgxj7EJWdnJplc0G+vBkrvPe7bUlDhb1HV7rU=;
        b=bn/vU8OZnQ/Ud8EolQED7bs6Sa944BHUHZ+xXEFW/qbB+MrDyMw7hdbdMK/98IPxlZ
         pqYufZtm/kAV5T/oxz5qFoDUQB0/3GdXiRkAqCZn8e7GtwqfWE9EjusIcsLbDEsnHAcP
         4RYgIzJL9VIBwuB22Oz8fs5qP6IoswwT15jf36b92kX5xHRZ5E2vUVqSGkk6uGFMXCbG
         ug1EOezbi84EnwJ7xRRVGKJGS4IHlUn8LrNk3S5KZ9Q1HCBMr7dbdze1ON0lz13K6Yh4
         av72WVkqeqIlcFAy+rP7j/T4PI8c+8gEOMEMGrvLf5SKsb1QwtfhMk/Rt62ogkVMGRUH
         yOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QeezRGYgxj7EJWdnJplc0G+vBkrvPe7bUlDhb1HV7rU=;
        b=YVXD09X+pnjxa+h9O+DVLEhRGl/w3BVuhltxb6cMJWbOlpRC0hj0QEcufNYhmSvIEB
         v04dn8vwlKMGDodzEWoEYKwRl0dN84SZ1eW1MbZckqtqUX81Q0cpIn5g2n83GyKH3Adx
         a6DHSCNg5DiVY+5b02rW711zi1GyctzpJolBtidueb0HcBKd3CqJldZOR8rIZuthJJjg
         S5GIKQZGXtFM6iwyoBr1WToP7Zp9zd42Z1NtIjLxkbZ9AbMc10Kv6VOSF/GrieYkhlUY
         AlvyShpH55FeN9tvmc4VIfdqxxXQT2o2q4AysNqyqp5f+IBaeDzLEVmvZGNwiwkKatCr
         lFAA==
X-Gm-Message-State: ACrzQf0QKY5aK6KgYKUtGtAnZ3QiIRl+n41v6FPxzxMoZGrDE9MfKOo7
        /DMoIcTf4SDkPhC2Z3YdB9A=
X-Google-Smtp-Source: AMsMyM65O7j+dkaw81J0CnvRH48uMvZTbLbhDTsoL1FSsxK7tpbliqXXuQ9xlmwGCxiMoxHj2vIpDQ==
X-Received: by 2002:a5d:6485:0:b0:230:b6db:d41c with SMTP id o5-20020a5d6485000000b00230b6dbd41cmr7362534wri.709.1666254100569;
        Thu, 20 Oct 2022 01:21:40 -0700 (PDT)
Received: from felia.fritz.box (200116b826709f00b540fdc83ad027eb.dip.versatel-1u1.de. [2001:16b8:2670:9f00:b540:fdc8:3ad0:27eb])
        by smtp.gmail.com with ESMTPSA id p26-20020a1c741a000000b003c6b70a4d69sm2020989wmc.42.2022.10.20.01.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 01:21:39 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: remove section INTEL IOP-ADMA DMA DRIVER
Date:   Thu, 20 Oct 2022 10:21:03 +0200
Message-Id: <20221020082103.29218-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Commit cd0ab43ec91a ("dmaengine: remove iop-adma driver") removes the
driver's source code, but misses to remove the MAINTAINERS section.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken file pattern.

Remove the INTEL IOP-ADMA DMA DRIVER section pointing to the removed
driver.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Arnd, please ack.

Vinod, please pick this minor clean-up patch on top of the commit above.

 MAINTAINERS | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8912c852d5a2..9839febf8b51 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10339,11 +10339,6 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 F:	drivers/iommu/intel/
 F:	include/linux/intel-svm.h
 
-INTEL IOP-ADMA DMA DRIVER
-R:	Dan Williams <dan.j.williams@intel.com>
-S:	Odd fixes
-F:	drivers/dma/iop-adma.c
-
 INTEL IPU3 CSI-2 CIO2 DRIVER
 M:	Yong Zhi <yong.zhi@intel.com>
 M:	Sakari Ailus <sakari.ailus@linux.intel.com>
-- 
2.17.1

