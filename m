Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285D23879D9
	for <lists+dmaengine@lfdr.de>; Tue, 18 May 2021 15:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349474AbhERN0V (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 May 2021 09:26:21 -0400
Received: from mail-eopbgr150042.outbound.protection.outlook.com ([40.107.15.42]:16129
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244483AbhERN0S (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 18 May 2021 09:26:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4fZP7yk/BPdm5T/YB0+g5mauybMA1HWbvKHXfFJMGIaFyY/4gr5KB94QrszV7rTZX3A2213vZeWNgNL5IHebzKOeNGSDJOfR9MAHt8YvMDXir64vxG5VaLC3ZkbO+ftg415TXpWyE8oE1A6kR4LfPn0SuXHEeM+Oop1J/ZY67AnM3NrLyFQc00o23Um3NJshky6U1nSUWGCabUuZpyLczdsLBmxsECKkRnooJ4rbwQbe3FfMJJkQKl2FnurjARU7v3b4jS4ncCw3vmFA+PB7DXlpnLNJHk1ifBMNPKrQ2qpWugnX6WiXSdTEMVsFpwPlh1W4cMJvTRJvrFDEIXllg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+Dqw6mfNyAwBqb9xMwyuOsb4PAEMgbLV0HH9bwITGo=;
 b=KkKZyJauCIm6iU9BQf7ExYuSMop5UGHjiwufJopQzsVPcBuWFwjDRHqfOEkhvIaIzlvXXy4bM6Ph9v5/u+ojTjF7ZwrcMVpP5BpwQmciwMIRS0hzT5ihKlQDDq6PiAHR/NTgL8WPCCIl39wlHb61tLdAMrP8KvFrxknZ5ERmVbtw0QilYae5PiGNt36SqTKuM9IkBV46DYzu+Irzem1m8yXshJcxcJQAeBk5dX/fW2t6IXssvymZq8kdfEOVcdeIga53ANyEitLMird5pxX5tdmlTnc/8uFyQ0O9nqdlKV5DWnbjAzKc8y5QuTx/NpYZjX0sY1tsqHCjli03Ulrniw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=orolia.com; dmarc=pass action=none header.from=orolia.com;
 dkim=pass header.d=orolia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orolia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+Dqw6mfNyAwBqb9xMwyuOsb4PAEMgbLV0HH9bwITGo=;
 b=Zyyecg/Wo0kIEWWGw5zi2Ln0H+hE6cqXRrfQMJfGfG0BdIgiQcEKz/2eS6yXoT49J0LjAWMFqFmKr2Y+oqhfV92OhQfGRwULTjfkgYA50t+LFtaP/zUcckZraJNt1DRn0ERvlWVFnGcgxVpYTYviT1ygf1np/049DBDrlOgXCXc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=orolia.com;
Received: from PR1PR06MB4746.eurprd06.prod.outlook.com (2603:10a6:102:11::28)
 by PR3PR06MB6715.eurprd06.prod.outlook.com (2603:10a6:102:65::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Tue, 18 May
 2021 13:24:59 +0000
Received: from PR1PR06MB4746.eurprd06.prod.outlook.com
 ([fe80::81ef:de90:c451:d6e3]) by PR1PR06MB4746.eurprd06.prod.outlook.com
 ([fe80::81ef:de90:c451:d6e3%6]) with mapi id 15.20.4129.031; Tue, 18 May 2021
 13:24:58 +0000
Date:   Tue, 18 May 2021 15:24:45 +0200
From:   Olivier Dautricourt <olivier.dautricourt@orolia.com>
To:     Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Stefan Roese <sr@denx.de>
Cc:     Olivier Dautricourt <olivier.dautricourt@orolia.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/3] MAINTAINERS: add entry for Altera mSGDMA
Message-ID: <f1b4a1616e4648edd17940fd8a07a903680177f7.1621343877.git.olivier.dautricourt@orolia.com>
References: <7d77772f49b978e3d52d3815b8743fe54c816994.1621343877.git.olivier.dautricourt@orolia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d77772f49b978e3d52d3815b8743fe54c816994.1621343877.git.olivier.dautricourt@orolia.com>
X-Originating-IP: [2a01:e34:ec42:fd70:167:681b:bc47:e8b1]
X-ClientProxiedBy: PAZP264CA0029.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:122::16) To PR1PR06MB4746.eurprd06.prod.outlook.com
 (2603:10a6:102:11::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from orolia.com (2a01:e34:ec42:fd70:167:681b:bc47:e8b1) by PAZP264CA0029.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:122::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Tue, 18 May 2021 13:24:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 926e2b1b-7e53-4466-522f-08d91a005590
X-MS-TrafficTypeDiagnostic: PR3PR06MB6715:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PR3PR06MB671546C368106ED38FA860908F2C9@PR3PR06MB6715.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:363;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v19KLRMK2u9w/fb5Yv4UNANvjpUKccQPaj21LXOoqmIA4xNq05kqjQTU5RHurfGnsgsxEH+qruClN8RUrV9z1DupFl4qbnMaf7iE2tAVMZPQzuTFHUsJ2t3X8SKRwF/CZAsxil/VmlaBW83IIOpYBFfPAeZNSaMhH4twZZuUANuv7jzIgwyWmWXTSRPBVrsx7K9WuQHNIbYAXehcFHKNMfWEQMX5a2xntE1zRjPZMAGRhbS4YgbhVmYJKkPiGPz0bNLE8l6x5yenNixOCwVZivCjhCxOv2nzQe4lN9mJE1+o9dp3+s5wGzFmXKe8pNEaDH5X/KugRM6pKrKQiDC+1j/z3THa8o5Fte170rdX4+QwXpgymqkp1KgSlKE/YEb28ByEXdvo25pqxrNHG9ZZ032WX+vDCTDGnoezMKi2a2aIOxcJ8DMnVph1ZnzjkJ+u7TRtdL9HOm35WsZ486dxKAlNT7HxXFVCBp+Ch/HT9T1ehEtZr9pSlh046jKdxp/wONhOHq5RrkL8dkiEedLNyW1rzTxHwCGNsz7EJhPDJMmBjQyiw5KRRVVqE/7QWWWUrviS9gSW0NFeyTje6Ji/mQUz8ove3QPmue/u9qnczEY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1PR06MB4746.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39840400004)(346002)(366004)(376002)(396003)(83380400001)(6666004)(478600001)(66556008)(66476007)(36756003)(66946007)(2906002)(8886007)(7696005)(110136005)(4744005)(2616005)(44832011)(4326008)(186003)(316002)(55016002)(8936002)(16526019)(86362001)(8676002)(38100700002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?GqaCqKCIbfnmYuPALRwNRHPgAeVn/rlntsaRAYF1/MsXQC6FOkmYpvJUmBeX?=
 =?us-ascii?Q?XVb1U3R/9egao+UAHAuFNWB8dhqMBk1TK/Tz4kahVOepnvH5632FAm93Nakx?=
 =?us-ascii?Q?8gaXw+HVX399LUdjYJKRusTnLwmSL8w0A3LR3yiHQehk1rZtU+3gJG9I0642?=
 =?us-ascii?Q?vRmakP4i0xXZvxCO88hnh+o3taa7sfxQ+iw19sqvZ/I3taWdIZ94jRnX4w36?=
 =?us-ascii?Q?/7mJ47lI2Y9y70b/fd9jGwsU4+KGFyIQGDEIJD4zkTLqnpomUQ+l3ceVmQXb?=
 =?us-ascii?Q?5vqPqkDLChMXeKNWOhYS+t5IkbdraT90/LwG4g0tC18SMl+w3ZqUhELcaNOo?=
 =?us-ascii?Q?xj5N4VDThtKP6tZSayVX3zXtbyfC7NHLHzo/98/JMIBENVFfFnFAffOGqClR?=
 =?us-ascii?Q?2wwrp6DjcTuZ0UtSNHVQk4bIVDaQ4zHM6O7/AS8j8Ns+cM18KqISOrO6p5p4?=
 =?us-ascii?Q?7tbAmEFjzqlQSeFVXtXQUM5Skz2L3x0lNquLKCTtT93Jeze7CXTbwTiiipxV?=
 =?us-ascii?Q?xI2L/B7kRgtNJgUQMXgylaVlVeTZcLUU2Bm85Jlurom0IN8tDJAzOeF/vZm6?=
 =?us-ascii?Q?E+pW+z4cffA6EIIlohRL/6YW9WWKYrfsBnEW4sDKAovlkyOGEZWDwVQFntxq?=
 =?us-ascii?Q?KuFe4XN1KPQ5SlW3Nnr7rjpFgkVSirlR/h1n+vhcBmSNtCGzc0wOg3dWtPyb?=
 =?us-ascii?Q?0hG1RuEZ+aCD9Y23L2YUKipTRfaGLTsmBZFvkjgxL1QvDKVOX25VsR1d1BUy?=
 =?us-ascii?Q?/jZojtyH+3IFGjQcm/NJulM2Q0Oxn93qMba3NSWIsoPR+5qG3+za1yJj+zji?=
 =?us-ascii?Q?Xov3hQcF1D5EwGwxI5IO0YkfI05cWz9yA8cKVTLBNjkt6pARlQDiAY+xqBUx?=
 =?us-ascii?Q?+iJ1BumkULXVyOfHtmJILC4uwFfBtgKEt4ee/Qe9S5uiR6i9DGcFuEbRm8YV?=
 =?us-ascii?Q?zYLMltFcQ0VksFx6OEmu1qQSJyU564KOTGV7c0JaYNHREPdzRbLMS5zVXePF?=
 =?us-ascii?Q?yZbzPicFVq0SDWaT5oUGBMi2ihptA1yh4AvI/8uSw8OCtz4oo2ZM1O9DH18f?=
 =?us-ascii?Q?uhRKi6N7LaEeH9650Hbv5vFcEfqPxaEQ5/bd8XtrxXgtS0QqDLr8hSsPASvX?=
 =?us-ascii?Q?GGmMhdO+F/62+gLR7kLObp1bXQXEivxRy17uYvvtZh4FsOlcDxHB3HzvOoP2?=
 =?us-ascii?Q?mix4xPHIgS5UEdiXzQovSC0aju/QMKiP9fFadKDmdO9mi+dUz24jnndX8OM1?=
 =?us-ascii?Q?RcIjyI8H65oQpjARpNOY62xMYl67MF4nJEdgybFpEkm+o6MThbPfRbzJ3xbG?=
 =?us-ascii?Q?UmIEtczY8pPukvjkJFd1M9FVLpoJ8fWuI4lAcBBYNgWyapeka/GfYoqdrYnx?=
 =?us-ascii?Q?j438L9FIy3Q/86qayUohlDQjJ/DG?=
X-OriginatorOrg: orolia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 926e2b1b-7e53-4466-522f-08d91a005590
X-MS-Exchange-CrossTenant-AuthSource: PR1PR06MB4746.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 13:24:58.8519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a263030c-9c1b-421f-9471-1dec0b29c664
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ky3KhUOiD2boQdp5lMAWRNt1PG9ISmz/38DUVsCAJy3DPMa8FBjSXu8iVJIQiDVOYwKjotxp+HcXi5rvxuVUJOyYXmQNjxE+IFzAPonaA8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR06MB6715
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This entry is for the standalone driver in drivers/dma/altera-msgdma.c
Add myself as 'Odd fixes' maintainer for this driver as i am currently
writing new code and have access to the hardware.

Signed-off-by: Olivier Dautricourt <olivier.dautricourt@orolia.com>
---

Notes:
    splitted commit, introduced in v5

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 008fcad7ac00..ccccce849b27 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -783,6 +783,13 @@ M:	Ley Foon Tan <ley.foon.tan@intel.com>
 S:	Maintained
 F:	drivers/mailbox/mailbox-altera.c

+ALTERA MSGDMA IP CORE DRIVER
+M:	Olivier Dautricourt <olivier.dautricourt@orolia.com>
+L:	dmaengine@vger.kernel.org
+S:	Odd Fixes
+F:	Documentation/devicetree/bindings/dma/altr,msgdma.yaml
+F:	drivers/dma/altera-msgdma.c
+
 ALTERA PIO DRIVER
 M:	Joyce Ooi <joyce.ooi@intel.com>
 L:	linux-gpio@vger.kernel.org
--
2.31.0.rc2

