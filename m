Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D83E4262F7
	for <lists+dmaengine@lfdr.de>; Fri,  8 Oct 2021 05:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbhJHDdC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 Oct 2021 23:33:02 -0400
Received: from mail-eopbgr1310094.outbound.protection.outlook.com ([40.107.131.94]:12856
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229501AbhJHDc7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 7 Oct 2021 23:32:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9tyIX3W4rsnsu7iLSSCr2sxR0ZDFhlxMncM2UxSOuccjeX6/Pt7RxVoc8ygW2Zd3TrUvkKadnKs6dVwqP2vVmqd193F3Tj/PUvkFTIC3awUww0ziGxenp2PcHKjv/10T4ANU5CPaYzD2rBk3ZG5eneqsX95rDVOPjR4OwK1R9jMZD4qQnRp12WdU5LvOUI9GUGclYjMDRnH+mS8Yv9DWv6jNZAV8+iZOpNgNQF5uQP2xjwZZRcHWvUAuklbhC/Y9OlD9uSZR6UMvWUMxFwrxHaY45uT85j3anjD/Z2UalZuc9JqO9Ss4qqFJ28Oj5nsj/p72EvIMKzGArV5wdck3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1w/C5+Pj0azalLvyR0t9to/H0dVxUYIuNKLdDFSyRw=;
 b=cL2Gd3jzT6B0aAm914rXIwKj8zT1rU4KsyQHZpUJ1wZDdE889zoE8kcC2Qx/VoWBvuHBZ5qDSfACehNEibkcvtoE+R+CLwZ486eBlWUmfspgm1X5K1yrGMcTVluNJJtRJh9JI7rKaAYiyGUkDYrLVHbqnFURxtOiIVFLcqI0jrtON0noZOmsqg5xB4rk3Y2VIOJ+tdh9A/cKLYDddWeC7S52N1UNCwhDfRn9D4eAy58sGUYYmCLfaxbfV5KI0n2U5Vtze0QDiazfCmF36qX4n7rU1ZQhF1s/JEFox+S1rtKdaTWGOnlcH3/uv3q8sglCV0oOBo7Q9hxnaMwqUoACIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1w/C5+Pj0azalLvyR0t9to/H0dVxUYIuNKLdDFSyRw=;
 b=PgDNoRlPPa2i/Bluf5tSpQbRIoEcyBQ1KkcVhxyw8toadCw973vxi2NKUWulUgoDGJPLaISA5IyL+5J8MPJr+GBYkMZBkSvOQUGevOzA7FxOizJ6SaJ0MUiyLk8w6yLjWr05aYlYjdZvT0wIIj1Aoz79vw1u4HlQmGMtJqCD7mE=
Authentication-Results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3385.apcprd06.prod.outlook.com (2603:1096:100:3f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Fri, 8 Oct
 2021 03:30:58 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4587.019; Fri, 8 Oct 2021
 03:30:58 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, MPT-FusionLinux.pdl@broadcom.com,
        linux-scsi@vger.kernel.org
Cc:     Qing Wang <wangqing@vivo.com>
Subject: [PATCH V3 0/7] switch from 'pci_' to 'dma_' API
Date:   Thu,  7 Oct 2021 20:28:26 -0700
Message-Id: <1633663733-47199-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0209.apcprd02.prod.outlook.com
 (2603:1096:201:20::21) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (103.220.76.181) by HK2PR02CA0209.apcprd02.prod.outlook.com (2603:1096:201:20::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 03:30:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11b823cb-7dc5-41c0-ce20-08d98a0c0b4d
X-MS-TrafficTypeDiagnostic: SL2PR06MB3385:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB3385DE6FA6F892B123416195BDB29@SL2PR06MB3385.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nOcDNUQUfus1Ha5jwG+418ewEZ6afoFl4FAQbqbz6G1NpehHGRZ+TSyaa6zFlufrSQz3CNeidWdhmr0tMmv79qD3u0HCFM1w7NbRdnP36tpQc8g693XIR/RhxHzYN33Am1hDrmXsyOswLLSJ1EyDy4tOjz6aULyG/UIBqJJKale+TEwOGP07wPaERBXGPbIXtBY5vMKd7d+h/5FVb7kMWwErO6NYhE4SXnLHMW7t6RneRo54SQb1NhE43E/kqB6aHCFjAL8C2HhWCQf+Y9QKOVAae9k675K+neJ0DyU9Rpz1SAG/ffaXcCTAcMFS9Bowx9T7mJm6fCZ0M5uO9gUrkxma3TpG58g1W0bGOOyRQ8q6Iww0gAKLU1END0sAzf9Y04spX1HDE0IRf/ISkYDk5b1WQ+bluhW8tfKviPmUxPAtaMxv7vIPFMWANha+L1xLKzxbnE61pQsfJlJV1D3lP04rO6Er5sKUtesBRUw7iHpFe5eguD6DnLPtAQz66LAR2fdR3wGznVBhtaEOR+hBmmpYU3cZjGNcMu28G19bwXKv4HRXJZ1K2HTi9QaRHWAOC/FJAx/5Ad6wzxVmSyTkFOkWkXIxzjq0Cv7mWBiUYs1k+yl3VPzln3lxDXmbllUIKentEhAqf9zj3J3IdnTZLP2IOLK/HULpbUxxoPUGTgb0l99GuqRC8Om/VQ3gFfdxYJwm2ZfhPaMxGQFxCE2C3f36XVTfACO1z1AvOm5M/QT0ShX09jDxe1OvzRMK3F69EczsBC+r+CmCJ6/NHnOacVtgTCXoTgBoxknlc0YKwBQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7416002)(2906002)(4326008)(38100700002)(52116002)(36756003)(38350700002)(66946007)(66476007)(66556008)(6506007)(8676002)(186003)(508600001)(86362001)(966005)(6486002)(110136005)(107886003)(2616005)(8936002)(83380400001)(956004)(316002)(921005)(5660300002)(6512007)(26005)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O+s2mpqE1Jv7NhgVEvU/D7Dx64kmKcCJTHvpRv+rjL98a3qs+DkLVNP7wcT0?=
 =?us-ascii?Q?sy+9N9R9AhxPPDbMOkcEKQUkA0h6hay4DCUlNMBd/PEkYX1maDBmE/DCxoG8?=
 =?us-ascii?Q?DUlX1u2bmUCiklDcupbEwCTnyb1SBIPTAgG8h8PGSrXGXeXeq9v+cJS45q92?=
 =?us-ascii?Q?ThqHwKp8LSIY6az9gUFIk0UKlfwEwjrAxWvMZ651l6cGn5y945EoEhzSN/wM?=
 =?us-ascii?Q?TXYz+lAdexkU0KxqCTthYKsAQBbLhpOZGWEyRprYiIm5LUbcoxpInp/y3YLt?=
 =?us-ascii?Q?JCamNc3802KLmf3pajfxIryoWMQs6IDee4B1th/idojdTi+phgmqLIK8Qj9Q?=
 =?us-ascii?Q?20AqEjgw3nclRfS1ymlkz/AgXoxT5kW36nx51teXA2B1gLQDkK5P+xgPxz40?=
 =?us-ascii?Q?Q1NQ7ZwRB7AA7h9YkhgMn051PoFSrCfvx/TGc77dpN82fmGjgQx0XBbUirid?=
 =?us-ascii?Q?khMf+3HY94mA1wV8I0/qIc8phnp+JlVylFym9HjrPv9A4Ph1UB/zdeloAlQL?=
 =?us-ascii?Q?/jLUGPeVU014+h9bBuKSP0dAPdNLB8JxZZjW9DMetAH8sG5+dZQKQzmswnSO?=
 =?us-ascii?Q?xhk2/n4867I73gUkt22fSXkgatgI7He8sL3mhRt5xk1ytj2ubL0Lisb4b+/T?=
 =?us-ascii?Q?nNuXncpK4up0YR/ngHsJDZHXgStPq1/pfF/nHLtKnuN2LIiPZTKq+169RP9Q?=
 =?us-ascii?Q?7bEJIfMgZYi6jc/ELgAKSiDCSOnTdcsV+5v4CWePaHGcQA/Ltc6brhvaqFjQ?=
 =?us-ascii?Q?x78bRc5OpAcJpyksuCGumqVA8vXNA5TIdgE+l0a+AIIXQk3QIf/cASPMhtB8?=
 =?us-ascii?Q?o3/I8fLND95rq0FIud795+MbyqdJc/Bs8GPkSv/78sq9o6vQvLZ+Gnkax5QN?=
 =?us-ascii?Q?oGnvHAmdXAAHbEMeG2wsPng2D8YBRX7MUOOtH81BiaQYcfvk68Qi3FFma+14?=
 =?us-ascii?Q?Dfm6VTkiQNPoK1FXD4H+BTHt6vTQ9sregdK97Ubh/Z5KrO1nRQI3fCIaeQdl?=
 =?us-ascii?Q?3cJu+LX+IG3t6BSyx5D195V6xbpjzwpIqHFiePbo+IQridq1hum81kqwoMdj?=
 =?us-ascii?Q?2P6T35w84gTvg3QFvJJERFcIC1hiYRIUVl+Bx1y62Dh4DLWE5pUvPV2XlKMn?=
 =?us-ascii?Q?X/CrsvsfWyHd55PYfAjt9GYzfq+lhpRaMfE2kYfsYeT+3/UB8o7cktaMDTHZ?=
 =?us-ascii?Q?BCM/F0Uy4fi7hCLn+TfOSlTDjw4+5ckFU2puODjiCc5ljrawPdbDKqPjNybw?=
 =?us-ascii?Q?iISd+2S86Mzw+O0Kaz9UmxGslHqaG/FVL3cgl+pdDfyQ8RlBfjNJfucGcKQS?=
 =?us-ascii?Q?xutBJkCSMJdb6zv5uR7v5zd2?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b823cb-7dc5-41c0-ce20-08d98a0c0b4d
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 03:30:58.5453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q7N373P75+V7NXrEMLpWyZLkvbkMPCoy2rpByF/qtYU6aYxvAC5YaaBKDmtCAZzbGCNIWZHmOiPUz9x+ySjBEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3385
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The wrappers in include/linux/pci-dma-compat.h should go away.

The patch has been generated with the coccinelle script below.
expression e1, e2;
@@
-    pci_set_dma_mask(e1, e2)
+    dma_set_mask(&e1->dev, e2)

@@
expression e1, e2;
@@
-    pci_set_consistent_dma_mask(e1, e2)
+    dma_set_coherent_mask(&e1->dev, e2)

While at it, some 'dma_set_mask()/dma_set_coherent_mask()' have been
updated to a much less verbose 'dma_set_mask_and_coherent()'.

This type of patches has been going on for a long time, I plan to 
clean it up in the near future. If needed, see post from 
Christoph Hellwig on the kernel-janitors ML:
https://marc.info/?l=kernel-janitors&m=158745678307186&w=4

Qing Wang (7):
  dma: dw-edma-pcie: switch from 'pci_' to 'dma_' API
  dma: dw: switch from 'pci_' to 'dma_' API
  dma: hisi_dma: switch from 'pci_' to 'dma_' API
  dma: hsu: switch from 'pci_' to 'dma_' API
  dma: ioat: switch from 'pci_' to 'dma_' API
  dma: dmaengine: switch from 'pci_' to 'dma_' API
  message: fusion: switch from 'pci_' to 'dma_' API

 drivers/dma/dw-edma/dw-edma-pcie.c | 17 ++++-------------
 drivers/dma/dw/pci.c               |  6 +-----
 drivers/dma/hisi_dma.c             |  6 +-----
 drivers/dma/hsu/pci.c              |  6 +-----
 drivers/dma/ioat/init.c            | 10 ++--------
 drivers/dma/plx_dma.c              | 10 ++--------
 drivers/message/fusion/mptbase.c   | 31 +++++++++----------------------
 7 files changed, 20 insertions(+), 66 deletions(-)

-- 
2.7.4

