Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7096F9178
	for <lists+dmaengine@lfdr.de>; Sat,  6 May 2023 13:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbjEFLSW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 6 May 2023 07:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbjEFLSM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 6 May 2023 07:18:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CD472BC
        for <dmaengine@vger.kernel.org>; Sat,  6 May 2023 04:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683371813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qy7lDPZv9XVIVeoAE9BllecWVloA7NmDgrIr51rk+t0=;
        b=N2QlYYzDOld/XWiqQByhjOw+MZrnj6MnVexMXjwxNGclAVFJ8ijLGRZQrSuK/oeymmea8o
        CitTvFHxb7+BldcsL0pvaaS3fXByCA7XUBFKQ93HKQZBy7nmArN4pPSFGf9O9EymCmGaCE
        aUnQfoTOhgp0q6wCQHKbdpACJLwMxNA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-155-ju83Lpg3MyaunKYUwqTUig-1; Sat, 06 May 2023 07:16:47 -0400
X-MC-Unique: ju83Lpg3MyaunKYUwqTUig-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 161E4380664E;
        Sat,  6 May 2023 11:16:47 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-46.pek2.redhat.com [10.72.12.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B51692166B31;
        Sat,  6 May 2023 11:16:41 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, schnelle@linux.ibm.com,
        linux-s390@vger.kernel.org, Baoquan He <bhe@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: [PATCH RESEND 2/2] dmaengine: make QCOM_HIDMA depend on HAS_IOMEM
Date:   Sat,  6 May 2023 19:16:28 +0800
Message-Id: <20230506111628.712316-3-bhe@redhat.com>
In-Reply-To: <20230506111628.712316-1-bhe@redhat.com>
References: <20230506111628.712316-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On s390 systems (aka mainframes), it has classic channel devices for
networking and permanent storage that are currently even more common
than PCI devices. Hence it could have a fully functional s390 kernel
with CONFIG_PCI=n, then the relevant iomem mapping functions
[including ioremap(), devm_ioremap(), etc.] are not available.

Here let QCOM_HIDMA depend on HAS_IOMEM so that it won't be built to
cause below compiling error if PCI is unset.

--------------------------------------------------------
ld: drivers/dma/qcom/hidma.o: in function `hidma_probe':
hidma.c:(.text+0x4b46): undefined reference to `devm_ioremap_resource'
ld: hidma.c:(.text+0x4b9e): undefined reference to `devm_ioremap_resource'
make[1]: *** [scripts/Makefile.vmlinux:35: vmlinux] Error 1
make: *** [Makefile:1264: vmlinux] Error 2

Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: dmaengine@vger.kernel.org
---
 drivers/dma/qcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/qcom/Kconfig b/drivers/dma/qcom/Kconfig
index 3f926a653bd8..ace75d7b835a 100644
--- a/drivers/dma/qcom/Kconfig
+++ b/drivers/dma/qcom/Kconfig
@@ -45,6 +45,7 @@ config QCOM_HIDMA_MGMT
 
 config QCOM_HIDMA
 	tristate "Qualcomm Technologies HIDMA Channel support"
+	depends on HAS_IOMEM
 	select DMA_ENGINE
 	help
 	  Enable support for the Qualcomm Technologies HIDMA controller.
-- 
2.34.1

