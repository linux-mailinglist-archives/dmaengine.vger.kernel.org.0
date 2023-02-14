Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD2D6967D8
	for <lists+dmaengine@lfdr.de>; Tue, 14 Feb 2023 16:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjBNPUk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Feb 2023 10:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbjBNPUk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Feb 2023 10:20:40 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5E326CEC;
        Tue, 14 Feb 2023 07:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676388036; x=1707924036;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GXFAjE3w5Hp1MZO7kiirgXaatEQp4T5QdFRWugDaxAk=;
  b=Lip/3XGjJ4CI01g0lFmyrVtgHPNfpAmabe6vgStz4Bzi6E59pJHiPQ1B
   70qcAKr6LbdaBX3wdcuFluOSzNLFMHs3eX49+Ad4L6z3vov3KecB+KY2W
   fmUcSfyeh55/4IdYTjKVDdJ2x7/YQJpwsuPUsTdV8rd7RvOiapYErhaXs
   Its1QQvORL2mdFJkYorW0aGPYo91tQHGTOZNXR8fPzB8V+dREpsap1J/5
   sU5veshW8N4VMrdfaaSueIVpP7SfEAUExhy8AW3bb1VrZRQvpOaf+OzFE
   wXdmv1YqOgiOBpkVAb6FDfh116vgjxYBtIrsgzG/uZAPGseZnkodVuxx+
   A==;
X-IronPort-AV: E=Sophos;i="5.97,296,1669100400"; 
   d="scan'208";a="200632632"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Feb 2023 08:20:36 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 08:20:35 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 08:20:33 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <ludovic.desroches@microchip.com>, <tudor.ambarus@linaro.org>,
        <vkoul@kernel.org>, <nicolas.ferre@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/7] dmaengine: at_xdmac: fixes for suspend/resume
Date:   Tue, 14 Feb 2023 17:18:20 +0200
Message-ID: <20230214151827.1050280-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

Series adds fixes identified on suspend/resume of at_xdmac driver
(patches 1/7-5/7).

Patch 6/7 just adds a warning message that could be used for debugging
purposes.
Patch 7/7 is a minor cleanup.

Thank you,
Claudiu Beznea

Claudiu Beznea (7):
  dmaengine: at_xdmac: disable/enable clock directly on suspend/resume
  dmaengine: at_xdmac: fix imbalanced runtime PM reference counter
  dmaengine: at_xdmac: do not resume channels paused by consumers
  dmaengine: at_xdmac: restore the content of grws register
  dmaengine: at_xdmac: do not enable all cyclic channels
  dmaengine: at_xdmac: add a warning message regarding for unpaused
    channels
  dmaengine: at_xdmac: align declaration of ret with the rest of
    variables

 drivers/dma/at_xdmac.c | 107 +++++++++++++++++++++++++++++++----------
 1 file changed, 82 insertions(+), 25 deletions(-)

-- 
2.34.1

