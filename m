Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DFB5496FE
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jun 2022 18:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350671AbiFMMZd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Jun 2022 08:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352058AbiFMMXR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Jun 2022 08:23:17 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B9857B2C;
        Mon, 13 Jun 2022 04:03:35 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id v1so10361577ejg.13;
        Mon, 13 Jun 2022 04:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=nv9GoUVVH7uRngOuTp8r8JipwSDkMSqF8EwMKb+wLjQ=;
        b=lweX4JOSNaCRO5akyTwcDXVA1trQpJ8i34ZEq//MqQludDHkLoAcUsFfNktCjrL36n
         DlMlsw71gE6bD4QA98ucWCDTp7TpJBjCRr2odbvNUJNXsBWMV+mJ3Mk6JRMtVYS8Nesb
         VDhl9nH0jH5lWd8uaCfJTzwOkKWUtbHL2DH7BbbGGuY5pYqvByfwsP9q8ypUMMCUQNVM
         d5eEFH3oXFx0Z9HtF7SSBdvBhi/oGL4wvyt137LHiQyViFivBy6rsBxDS9164VrNNl+f
         DiUire1aWv9MtGN+SM6xufyO0HNOzLXdEUOOe6ABJtwqgtO7uqFbligoHR7RbLLgtcLE
         FdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nv9GoUVVH7uRngOuTp8r8JipwSDkMSqF8EwMKb+wLjQ=;
        b=K5HhGJ1xnr8fg8D3aKFh8TwZdzNcA5VwhDhXhpo+lSxCpZ44rPBc6MchQaRcoCGMOy
         y7o9bo8oyaylr75WqAohyKLh23MXusXoHVW1iiwF38EgIb8/W12OOW0rzQCyV5+iSrKJ
         H3s7371/lcRFQ/mrvCmzbvK6q6PpODGF6kg14OLOsIyuZyLN11TRoApQDdhoEPqSxyqE
         aj+872pkLRyKrqumWXFslvH2um4TkOezuJZ6X7a8nZ3sOwTFpOSjVG1GQLjnfuq2FgzA
         Wtu9so+glPuBVsMf/UYe2sBxNJh4guC4b/34fVIrdNSyd69ndyBhTCgd9QUPD0qucsZ8
         tsYw==
X-Gm-Message-State: AOAM532QoV1VdJ57Ku5+osrJuEsDRGV8gQKXpE1GCQfxhtnKLU43+gsk
        pMLJCaq7S9PxXREiUyQ4VUPb1YdbvxI=
X-Google-Smtp-Source: ABdhPJyXoqR/cTKe5JJi789/bBIvh5hbOg5YgsB7TVy/RWs76LGLvkgiAs1muSzKlmw1BJjamCkPrA==
X-Received: by 2002:a17:906:ca91:b0:70d:52ca:7e7d with SMTP id js17-20020a170906ca9100b0070d52ca7e7dmr46766653ejb.552.1655118214288;
        Mon, 13 Jun 2022 04:03:34 -0700 (PDT)
Received: from felia.fritz.box (200116b8260df50089ef6db2443adc92.dip.versatel-1u1.de. [2001:16b8:260d:f500:89ef:6db2:443a:dc92])
        by smtp.gmail.com with ESMTPSA id o1-20020a1709064f8100b006f3ef214de7sm3721575eju.77.2022.06.13.04.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 04:03:33 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: add include/dt-bindings/dma to DMA GENERIC OFFLOAD ENGINE SUBSYSTEM
Date:   Mon, 13 Jun 2022 13:03:26 +0200
Message-Id: <20220613110326.18126-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Maintainers of the directory Documentation/devicetree/bindings/dma
are also the maintainers of the corresponding directory
include/dt-bindings/dma.

Add the file entry for include/dt-bindings/dma to the appropriate
section in MAINTAINERS.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Vinod, please pick this MAINTAINERS addition to your section.

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a8d243668992..1adf8767422b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5966,6 +5966,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git
 F:	Documentation/devicetree/bindings/dma/
 F:	Documentation/driver-api/dmaengine/
 F:	drivers/dma/
+F:	include/dt-bindings/dma/
 F:	include/linux/dma/
 F:	include/linux/dmaengine.h
 F:	include/linux/of_dma.h
-- 
2.17.1

