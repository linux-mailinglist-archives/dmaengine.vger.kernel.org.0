Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D309941A621
	for <lists+dmaengine@lfdr.de>; Tue, 28 Sep 2021 05:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238851AbhI1DoP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Sep 2021 23:44:15 -0400
Received: from mail-eopbgr1320130.outbound.protection.outlook.com ([40.107.132.130]:52584
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238850AbhI1DoO (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 27 Sep 2021 23:44:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QBNunsSU9bYq/lzil4zHuJoFZ0+BB3MEoP5Hr+8cd+edqNitA4cztxJN1btcdlIJatqUU3NoED57/+z3c+B5dcvg1+wiQyu7Y73+ep7qgQYNmJ3Jc4YLb/cfhnh4ixB0WUyqI4tLG6B380Nhtu6SIAeMTDwAr4JPBoj5fed/kF0Rm6df6068OsdI5ZTYyVk/oLRMAgPo5+VGQhm/gLr9K3f1rNQd7+eNajw9kWg9igHzIq1Gg5wnVaPO98SBRuMlV/3q1Z/qlyoPV2TSKV/4VWtyHl7mBv5SZLPbyCXjkCenjHP0DDtR2L+1QblibTZNk4IyuD2fGBIT5SWl5ihiHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=QHAHYoyTFlUZU9f8Oez/At/gP35zdRcz6kG8oTRwxOc=;
 b=LBNl/cTcFFspY5bbhiKNJVnPpbVE9fQ+YWx5O1nSUo9qMJblYkYamECmULhN4ubyZS0JVKNbetBeqjj2eS4QxFHM3vcORHy8Pd4vlxIeQwngIQvqASoRw35rDp7C7CmbGZNF9bZL+Rd6BuCyfLWSFB+ISnE1YUj2uazlBllnj8UL8l0M+xBpizt71Qgoe8QRSzDmma6Ycv4n30lS8q0sMInTO+5PJbWNvHIkzWigtblM7HBJWaxD4lDBFpizdmv8tK0jgcY7L4CBrMUXWCV/68cMLLdyIXqR3iemFHVPxVRZq/CBvb5fCRMyGAa+TtbxAaj0RdVEqjz5cmN/6k3i5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHAHYoyTFlUZU9f8Oez/At/gP35zdRcz6kG8oTRwxOc=;
 b=KIE5M8I3GfzEOEO+mbHhkOvx8xt+ryvsmGDLumhr5nG9TfvDQDwS9QmB4ZKVOiSi9sdcZ0J5R7GQ0ClQvS+3QwOXyg0doRoQzoMKyIxXqYj5bwQpmRWd01J1BqlcbfgEIS+P1PEwLzv6NqCFWnknr7RwpaRW/lX5P0aFi/4yqZU=
Authentication-Results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3401.apcprd06.prod.outlook.com (2603:1096:100:3b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 28 Sep
 2021 03:42:32 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4544.022; Tue, 28 Sep 2021
 03:42:32 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Qing Wang <wangqing@vivo.com>
Subject: [PATCH V2] dma: plx_dma: switch from 'pci_' to 'dma_' API
Date:   Mon, 27 Sep 2021 20:42:22 -0700
Message-Id: <1632800542-108522-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HKAPR03CA0021.apcprd03.prod.outlook.com
 (2603:1096:203:c9::8) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (103.220.76.181) by HKAPR03CA0021.apcprd03.prod.outlook.com (2603:1096:203:c9::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4566.9 via Frontend Transport; Tue, 28 Sep 2021 03:42:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da037710-005f-4566-987a-08d9823200d2
X-MS-TrafficTypeDiagnostic: SL2PR06MB3401:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB3401CA2D313D41BBF24089E9BDA89@SL2PR06MB3401.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FHrKXB//nOMPOvFdYstb91wmfbz4LKW5dduhnvCcGx9JcIZNubEwni4SESa5HKtoNRh8BNa/nj3a1QlFEU3iYD51jw9TUwhI80HYagTyQob6FTSPpOFZEanSXD+r6yNhWC49cI1eBdW3oqf0ZmUKrrzHU/Iwjh1n9/ChQZwu0RT1VdPrDqJOFy+jotZKDD+ug07Oocqz83C1yCGf2TKkHUdPHQUlcOCUlXfXg2QxBJKBAwC+iXtnVTzaiYIrxIxhvh8hCYeHEoHVe6Jf4YPSoV1gDpYsjhSBCIkhclI6+t//o6RjoAk7vczQel05qTG9KBtY/DXGRcwZqeVMmYJLgPbBs/6yEPHp+mK6hYbTBT3otB9QYvF61ezjhpJIER/c3HUwr0/c5Q284oWx3dRBBLxrlePag69fzDbUZzWOTloDngj8gr9hopD7U/hMsruBZyh6qgYAo7mcccY9a/QPPodcuZ7zBEsX9qrXwcNJiY+YH0gdFKXLkdy50w/mg5xYrh8XbavaLCrShjTnNVBCVE+lXu6/GHUse7EpWJ5bG/AuL5JA+ZNJ6Vy9vJH5CTewFcMmkJAWfU8ATd2HERoq+x2fpGEcAcOCAHxMNjGoPm+0h9FiDF+M2aDe4uZipFlu5wGkavoPyqfA8kxCa9aGIRh8TS2dn7cVB/cy5i8a7ktkJbdL/AHw/H0Qs2/QxQjIqNu3kg8MJlkpJj/cphk39g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(38350700002)(26005)(6666004)(66556008)(38100700002)(110136005)(2906002)(316002)(66476007)(66946007)(508600001)(6506007)(52116002)(36756003)(2616005)(4326008)(6486002)(5660300002)(186003)(8936002)(6512007)(107886003)(83380400001)(86362001)(956004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fwQuvIktjZJ1aUOTmfoXdsjp4WoeaqNqdTFmRoqp6dN2xhOXy4IZniISPd7k?=
 =?us-ascii?Q?2/ianpg6WsIAysgrd5QAYFHsCcTItiKqT5CHYbZHgV20fIG4Y431tjpeLNHo?=
 =?us-ascii?Q?49na0r+cagpzQGLz7l5tVm2/b67DXu/OPyGznD3K0YFKQ+IUP8Vht/nLEFjx?=
 =?us-ascii?Q?msJ4VNfZpCh0Kv10Z1M419kWVamJ0nYnOGZVosHRarYHxcPwvEGxGzBOEe6q?=
 =?us-ascii?Q?9YoQ7+Yarvj8DjIGfH+/sOeMJ+39/Ze4jOCYxClvFIHoRPpvXmSTSFn/VWuO?=
 =?us-ascii?Q?xlb1dPPXmskpHXlUtwkBbKKurttOGdaAVMpDe9Unklz0brQF+Uy1nPl5ypxy?=
 =?us-ascii?Q?tkwVpuOqBD8TDZrGuG3+/U9IVm3dge4mz2KA9bVk+QGow4yvSfGwfVxOEAHx?=
 =?us-ascii?Q?X0sgP3kNKnMX01j8sdyTU0lZaUUdLxY/lvPbapkhtj5znKhrdWtqBGEe/jmm?=
 =?us-ascii?Q?HAFUjRwfBW7SbIkwwgRi0fSsh5Mw+dQHk7A56Fy2vI2JgCbKEkYS2nPHFN4b?=
 =?us-ascii?Q?8wzWE2LBx+rJtZBJABRhusoaLfE71/rfrolXHgs8WcekwO2mLHelMHXEpDAy?=
 =?us-ascii?Q?n6Vibclx2HyivNTIvJPBXvXLBwvSF2mVvvO9YYnjw/MfnZ4VTQhHdnUzBlVN?=
 =?us-ascii?Q?Klslh3Z9n8lSk1c3TUDlC0BlShLgUiHaDwFE8y7+UL9rLcwK0jJ8ZrHjGJZQ?=
 =?us-ascii?Q?WjsKAhfkxfbqci7+r04R6A3n6zOIEMOFwhyYbiws9JwYrdiwCgpNkloH5q85?=
 =?us-ascii?Q?eF8FLTqkz4GBeYIz85X99xjQvEb7nmCk2URduCc9syqWAbab+2RGOkkEsvRs?=
 =?us-ascii?Q?1pWm8yv6WYwYwNlgQaioWHlG709wuOFNj2Hlm5OQyybVaAdfbzqmLG8jE8VG?=
 =?us-ascii?Q?6vh24xamQOtS0dLY2LTzIe3nIN2pJv1H7kpDFAG4COLf+3uXmgbNg0mKhW9K?=
 =?us-ascii?Q?o+BAWN/UCcJeF7giPg5oBZBE5GRcFZ4Vj/tUkaDVSLcPlEOizRbg0Bg3OStQ?=
 =?us-ascii?Q?T/1AWhByRwEtaTm9IQhJ3Qs8WD6xkWtPg+OiTvzjl5wze5qDozlVPm7hRwmp?=
 =?us-ascii?Q?dFnZnEUXfEK+ZvoDxYfczYiL/FNRRQhlGN1DDaOufZRxIfKZ9KuGafwcc5pR?=
 =?us-ascii?Q?JRU4e8cZlm809/ACEoaJdNkassQuziFkvuhNVPuZdj0iSNHg9pIBdbIoCgaE?=
 =?us-ascii?Q?6PEqDtHOX1tYL73WdJa1KD0QTD9z2nmPqG2XCbeVSlZkswGB5p7WKJU3jTnr?=
 =?us-ascii?Q?tjdFuaVMIqAcZiDN/m7kQCokfudkLEkzOniTxYPwUj5Hh6XGZ7W1XJUV6niq?=
 =?us-ascii?Q?ViZcw9xdY//UI0Fk4yvTadJD?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da037710-005f-4566-987a-08d9823200d2
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 03:42:32.4662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rq6+xkO2693rsLCf/l4gXVYopq80HadtmZ+r3xJvEzMWpQNrgHrWw8ivm87j8z+zl0X8D1wL+AohZUbgHP3csQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3401
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

Signed-off-by: Qing Wang <wangqing@vivo.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/dma/plx_dma.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/plx_dma.c b/drivers/dma/plx_dma.c
index 1669345..1ffcb5c
--- a/drivers/dma/plx_dma.c
+++ b/drivers/dma/plx_dma.c
@@ -563,15 +563,9 @@ static int plx_dma_probe(struct pci_dev *pdev,
 	if (rc)
 		return rc;
 
-	rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(48));
+	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48));
 	if (rc)
-		rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
-	if (rc)
-		return rc;
-
-	rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(48));
-	if (rc)
-		rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
+		rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 	if (rc)
 		return rc;
 
-- 
2.7.4

