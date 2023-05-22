Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC9F70C21C
	for <lists+dmaengine@lfdr.de>; Mon, 22 May 2023 17:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjEVPPf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+dmaengine@lfdr.de>); Mon, 22 May 2023 11:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbjEVPPe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 22 May 2023 11:15:34 -0400
Received: from mail-out-3.itc.rwth-aachen.de (mail-out-3.itc.rwth-aachen.de [IPv6:2a00:8a60:1:e501::5:48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DEFCA
        for <dmaengine@vger.kernel.org>; Mon, 22 May 2023 08:15:32 -0700 (PDT)
X-IPAS-Result: =?us-ascii?q?A2D4BQDNhmtk/5sagoZaHgErCwYMIoRxAoFbCBOtfodXD?=
 =?us-ascii?q?wEBAQEBAQEBAQgBOQsEAQGKYiY4EwECBAEBAQEDAgMBAQEBAQEDAQEGAQEBA?=
 =?us-ascii?q?QEBBgSBHYUvOQEMhmosAYEAJwQbgneCXBMGrhGBNIEBhHScTAaBQo0rhj9Dh?=
 =?us-ascii?q?2AEiCAEjymMC2eBMHKBI4EogQICCQIRZ4EOCGaBc0ACDWQLC2yBO4ErgVsCA?=
 =?us-ascii?q?hFCDBVdAoEEEAETAwcEAoEOEDEHBDcsBgkdNS0GXQcvJAkTFVMHhBU3A0QdQ?=
 =?us-ascii?q?AMLB249NRQfCAGCRwRxGHtPnH4Dgm5lYiClSaEIAwQDgiuBWgWLdJUJLheDb?=
 =?us-ascii?q?AGTMpIwLoc0kCcgjTqaLQIEAgQFAhaBelCBLnGDN1EXAg+SE495dQIBATcCB?=
 =?us-ascii?q?wsBAQMJijEBgRQBAQ?=
IronPort-Data: A9a23:mXSkCa2xx4fd3ZvLfvbD5ZVwkn2cJEfYwER7XKvMYLTBsI5bpzAGz
 mBKDWHXbPzeMDPycttwaovko08P6JKGm4cyHVRo3Hw8FHgiRegppDi6BhqqY3nCfpWroGZPt
 Zh2hgzodZhsJpPkjk7xdOKn9xGQ7InQLpLkEunIJyttcgFtTSYlmHpLlvUw6mJSqYHR7zil5
 5Wq+6UzBHf/g2Qvaj9OsfrawP9SlK2aVA0w7wRWic9j4Qe2e0k9VPo3Oay3Jn3kdYhYdsbSq
 zHrlezREsvxpn/BO/v9+lrJWhRiro36YWBivkFrt52K2XCukARviPphZKpEAatgo27hc9hZk
 L2hvHErIOsjFvWkdO81C3G0H8ziVEFL0OevHJSxjSCc52Dtc3fvyvdKNW1oF5Md1+hIBlhN6
 +NNfVjhbjjb7w636IiEdslBtoEYdozBepkApnElxD2fAftOrZLrGv6Wo4YDhHFq2IYXQKu2i
 8kxMFKDaDzpaB1OPxE0AZQzhvuAnGbjc3hRoVmVqKxx72W7IAlZiemwYYaPI4zQLSlTtkuG/
 zKaoFbwOBoDLPGv5Ce+tS2ojNaayEsXX6pXTtVU7MVCjFiay2ocCRsbfUW0rOP/iUOkXd9bb
 UsO9UITQbMa7lO3TtTtGgbi5XTCpAEAW59ZH6s25Wlh15bp3upQPUBcJhYpVTDsnJZpLdD2/
 jdlR+/UOAE=
IronPort-HdrOrdr: A9a23:M7bQHa3o8YwmZihyEc9x+AqjBIMkLtp133Aq2lEZdPUMSL37qy
 ncpoV/6faSskdoZJhAo6H4BEDuexPhHPJOjLX5Xo3SJzUO2lHYT72KhLGKq1aLJ8SUzIFgPN
 JbEpSWf+efMbEVt6rHCUKDYrIdKZG8gceVbMnlvhFQcT0=
X-Talos-CUID: 9a23:XZzTFmNl9yOZCu5DdQJn+E0dGOQcXiP30nL9LXC/MGV3V+jA
X-Talos-MUID: =?us-ascii?q?9a23=3Aaei2yg11FBpdTH5tuylQu3xSQjUj7rr3WBxSo5w?=
 =?us-ascii?q?8sNCcGBxdJgza0zC9e9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,184,1681164000"; 
   d="scan'208";a="195942182"
Received: from rwthex-s2-b.rwth-ad.de ([134.130.26.155])
  by mail-in-3.itc.rwth-aachen.de with ESMTP; 22 May 2023 17:15:19 +0200
Received: from RWTHEX-W2-A.rwth-ad.de (2a00:8a60:1:e500::26:158) by
 RWTHEX-S2-B.rwth-ad.de (2a00:8a60:1:e500::26:155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 22 May 2023 17:15:19 +0200
Received: from RWTHEX-W2-A.rwth-ad.de ([fe80::3504:6d5e:7248:8a1e]) by
 RWTHEX-W2-A.rwth-ad.de ([fe80::3504:6d5e:7248:8a1e%11]) with mapi id
 15.02.1118.026; Mon, 22 May 2023 17:15:19 +0200
From:   "Kanert, Achim" <Achim.Kanert@rwth-aachen.de>
To:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: Possible issue in dma_direct_supported
Thread-Topic: Possible issue in dma_direct_supported
Thread-Index: AQHZjMAlkqXRK2WpeUa/Cs6UyujKtA==
Date:   Mon, 22 May 2023 15:15:18 +0000
Message-ID: <945b8dcae7934000aff139994160a201@rwth-aachen.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.34.100.34]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

I may have found an issue in https://elixir.bootlin.com/linux/v6.3.2/source/kernel/dma/direct.c#L579 the comparisson in line 589 is true
for all masks >= 32 bits. So if a driver tries to set a mask of 64 bit, and the system only supports 32 the mask is set to 64.
I discoverd this on an arm64 system which only supports 32-bit DMA for PCIe cards.

Is my assumption correct?

Regards,
Achim Kanert

    
