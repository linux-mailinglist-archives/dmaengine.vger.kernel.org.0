Return-Path: <dmaengine+bounces-9397-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDQbHPTvsmnAQwAAu9opvQ
	(envelope-from <dmaengine+bounces-9397-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 17:55:16 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1277F2760D7
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 17:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1043B315D266
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 16:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3353FBEB0;
	Thu, 12 Mar 2026 16:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="m5odVcdq"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020091.outbound.protection.outlook.com [52.101.229.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8453F3FAE0F;
	Thu, 12 Mar 2026 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334229; cv=fail; b=eEmQGMKXU9Be+aWZTmJIWeOIl2L1CJQXXZA9Og/Pz+cIhXidwZFburKEEQvAMzF5rNfwA5oWN0MEKMC4V5KV4IBqoFhtcHYfsKuw32wL7WgCjzcJ2HpyrEMUUFiRgClr1NIa9SaXqEYSCn2VOK+3CWntWPfM5uG30gl0HP5k/6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334229; c=relaxed/simple;
	bh=R4Af//DnBWdRec9nbC4sgh10l9U09fxzPAMHrNQzgXI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MVhNfiTily+01nLbQKCkj9/HEe1AhXFV5YrjeJyHQhpfV2mNog5b0KHLDYAvSOm/Gt4TYpteRfLGJIwvFMvnRsKNx4czi9flsAojHR+tLmDkYfuLIXnqQEcTnKPGktVtDyoPS6nd7HnSRujXIUyBJt5fnGu1fLq1o1o9c7hXLks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=m5odVcdq; arc=fail smtp.client-ip=52.101.229.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0V/7LQ7UpkFNxMkmCqf0NOMOTUsEipc1B4Weo3gciJhneCMPQR2G2Xm/H4ovVf1C3EXdW9jDl1vdFZOaC9b6bWVIX4TpnGnlKJehYBMGR6INo1CUoL8yKfTrLsPo4sv4Ou4/ua/WDiY6hiLRyO8m98htI5Mbdk49kydnaL+ienCO2PHbnnLiXclnONlaJkhxZjhZihGSOH/2Zb6f9yU2HOw5lw6P20GVUZoBaHaOflPS+uabk6Y4qeGk3Z9dfZqNEILaXKiDIh/XYXFZ68/ug6Jml1h8vb0Ct7Qf8iVI0N/9mcqMMsvQ8EopHkaMSjopRvbId+e/UsTEAvevu8nyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxJQeoAlhoghMUAtW35gSSZzKNLZUE+LxplLQsI6Uz0=;
 b=ZpksSTgHzGqGbfnjniMHIS2Ag+gGRU832YUEdbkZbhJzDcdHHpXc5wblZ45Xc/Ns2Rm5HhTNJ+mb4K7O4hqGyF1Dk9XxqffKx2snvPZ828Uf3ikj7QBHAiegh1kn+/apOqzjXbAOWPxF77mDAFw7zNyyd9t72WPONpQd0SvXqaB4kDkdp6e2BCobbBlRckFrBKO6NsBbkWJwOkyzlzPD5Jy0LA9VHNP48bGCCrUzs6BI73wG2SfciZP2oJVhFxDNS3DuzbPT+JIrzLTe5Se77LvZKWtoW+Pe4bUL0oQtB+pkSVD6UK9E+XhILc83B2RVefPWtEYm5aRvoCMRd97p0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxJQeoAlhoghMUAtW35gSSZzKNLZUE+LxplLQsI6Uz0=;
 b=m5odVcdqAEVF9krYcb/v4qQD7PZT7x7C6TMDkIApq7S7/T5v0gOCRjXeKveZoAwiHJuDcBvkDWSU0riMgVIwK2/gaLjsU1OrycwtnHd/ssx7A7Ivf6tV7h/ZlhfNol3pqeEaGW8GgBza9q1Sat8/T/XXt+YrSiLtRkvRhJegG5g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2018.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:15e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 16:50:11 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9700.013; Thu, 12 Mar 2026
 16:50:11 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Baruch Siach <baruch@tkos.co.il>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH 00/15] PCI: endpoint: Remote DMA support via vNTB
Date: Fri, 13 Mar 2026 01:49:50 +0900
Message-ID: <20260312165005.1148676-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0069.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36a::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2018:EE_
X-MS-Office365-Filtering-Correlation-Id: e3d37ce0-321a-42ac-0ec7-08de80576ced
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|7416014|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	hPrdBrz2GhX3xDZpfpnuVkU6Z9VtnS2zJGylmPhMF66ybupfvE8UvBWISeDEN/0L4lQGkoTUn2JnT+kRJcoRGrBHkUfWkbdv9FA+1Y7eaI5Mi2XRXlVE/jgkKx7Y2KE2FtDJuV441Skoli2m1nU0xNL2gIJOdb4nbqq1djJp3+/z/8JOSdtSk+jIpRdVqSoOYoDK8/0EEpHc/7Jg8DhiSss2LA2fEwK1IhZ7O70eMkV7uL8yz52SWQ5E2J8G5Hvg+iKe2HBGelGNJQ+ew6tqrqEARIyBYbSBT3e0dHppME6DELwle6oyOuOcETJIGxqnUeOsvJO/dbGMCRiLE4h0+5wsJwKdyPTGQWunNHj27oIMUduc6zv0zvTYF4ezO/vpnUeFEBmmPfLz0zM5hoXWHt6fCHtDRjw6EOjCx9Se2YzWb3sMXUnUzRJeiQRHSP6y7H7y1z5GKPQYN/KFFfOcOqHLWTNSgC5ENl/Xd+Xv2lUNDecmLMG7krLheGAcP96zn86ekQJpT1ZBFhfWHUd6TIJwCdOew4cr3sEtrMszBSBZqYneK19h9n1muoh9f7pnM7fNqIOrXrhVNfXGnfLgCWRgX0CrFl+GvL7x4I/P1utS9/1QJ+P2jafSkDoptPDqvg34pvlx+vgMB32Pq1Z9L6CXlu93jJsPpDETz4M2e7shEiXsPr0Lt/IgZnoJ0lJxbupyzyC5V3fm8Q1AfHZA4uEOz+XtTYSHZza4UxJKKhMYwXtaCaZHuZIhe/930TFT0gNK84Dtm8qBTkHixhjp+0tQPrgSFIlbzW/FmVUYdkw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(7416014)(921020)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4q19oRkgjTbZ3KlMDDqwYf/fQ6mvLx+BOngQDRvfQT7bXRFXjfm1lIjsT1e4?=
 =?us-ascii?Q?1bP+gKVcex5NtXS+x37po37OA+gTB8T5JCF5WfepdYyzYAxaRQ79EBVJ7Gca?=
 =?us-ascii?Q?zUXqPg1khKnB07oPWb/tG+lAt0hpDLt/892CZWDdpKa9Kjfba8iRwoJapp6+?=
 =?us-ascii?Q?olEZIS1MJZYrOm9zC7l1Fvh9thMC/+h6vQlJdZtgtvomWz2N2DDi2dUr3Qsd?=
 =?us-ascii?Q?NVDFuvD/x472jN/AtJHsooPAVSBIOdHuXd85O0T6pw03QSS9MrByGF+8mdvi?=
 =?us-ascii?Q?yuIUbWV0c2P9nemanikWZ93FLTpo+E9M1l6EHTwPFjC59jNisf889yGU5PYF?=
 =?us-ascii?Q?PZVbfPpQF2CQv6BCFb0rI8ytCgpBpRjsk8R5T91E5MeIMlzGyqp7x8MVWqdH?=
 =?us-ascii?Q?gN5lmkqgVh/iXx0ubuprRshKS74f2JG1SHMjpnapfXXmZlRoZTWxLr7QQH8Z?=
 =?us-ascii?Q?UQGvcqVLaiXDmnxqwTzubhuOJEMN+GUtKzpEua1O47ZmJ9Wv73Zjmk7nJ6nk?=
 =?us-ascii?Q?D3dMvC2QOhlHyw8MAwEDhlaxNciW4qPSRhOGHSC5TXDFvGqjymF94P9STnt7?=
 =?us-ascii?Q?+HUzeAxaIUAoNjW+dthQgLjAZ5/AsI3OdAw83jfvUBImYvfzhf6/ZSMQsBH0?=
 =?us-ascii?Q?F7b5svIZFMNZLxRSMPQNbAMgHOH5S+UwODqZ8IeNw0deK2jMrbdPDCKmBZvZ?=
 =?us-ascii?Q?Nt5DMB45RN7C/7FFS4J5HZTDhcWzKVkubzLZCP5C0+Lpin+41heh5gADtVKU?=
 =?us-ascii?Q?JqORh3cYoVQDWA/d2tf1NMPyFBuGVY5Z83ABNnxeybSZYyaqLJeCJsBtYW5Y?=
 =?us-ascii?Q?4h6rJd7hb/wMlL9rls9OYP+/2/2nbmrqkPU8hwYYEoM302ZWxSb8lhhXBfZB?=
 =?us-ascii?Q?ILn4XZ3ItpLTnxgqviQeJW/BhjcgugOIqoB67NZs1+1xptvbf1jdCAjyfrJr?=
 =?us-ascii?Q?qNOOZx804/btdKoGVIW3RByf4lTZwJAiXT/1CpDQzSfRE/vfb1srbG6EpnI1?=
 =?us-ascii?Q?+tLeaLMTIqZxgx+A1tZXsgyXvcKxK8iXBSptiD5b7GLPCSu7krukEEX7xM+j?=
 =?us-ascii?Q?F0vP9Eh4NrvujvmsDWhSGuT2S7Lw6qt0OaPst4ZTf89T4ooT6BlHJr06RFZD?=
 =?us-ascii?Q?fzbW1b9ey4YGv+I7G/9V5IGzqTW4QLpAG5EK1V21Z1w8XmV35x3eTW3gb5dx?=
 =?us-ascii?Q?/3+FigGeH0DPqCYc+FA9LkBcBRgM+8ifhfwyOvTaBb98zNvVltJIiujcHO0Y?=
 =?us-ascii?Q?9BSqeJleLQWYj0L1MsPf6JTra3tPny1/x6NByNeA7pemxRLwLfCpJTyhpVg2?=
 =?us-ascii?Q?Bukd6eNq4wM3Ny4xSun5Wvy0u9M98IE8j758BY+tWNyy6kRr4HR+WVvPWN/S?=
 =?us-ascii?Q?b3mRUKCeSiGAos4B6n9geYq3caqZvxZP+nc40pwqDNkH+79WoQvyWvymFvvN?=
 =?us-ascii?Q?beaccuzr+3rMTqo9Rpnzud08STKkV5LefX9dxOds9UfN+aqkMVInQs924diB?=
 =?us-ascii?Q?r+TrfYWBgAGupr/yMJCs8wQXyvy0v8bq75+cS8Fpjhiu9FeLXvZE7E71yFEi?=
 =?us-ascii?Q?9kn3D4A/Y3fho+Ztg1QuV+MyOMId1BM9FkcNhBvqjOkf+uAfbjOiV7gx0PfG?=
 =?us-ascii?Q?fz+N3gvRlZYOwgufPiPFX8WDripyDxooLaUUr/bdVawL55pm+elpIcmvGFMV?=
 =?us-ascii?Q?EK/d24WOMzB8haILWblVJhk5AUJ603zUjfYaQkYHWrEPM5SlwqhoICGcCwbY?=
 =?us-ascii?Q?EH0+j5/4+ddI3l0h/kZ0eYP0kDD8EjCfzSzhs41JsCnSIgmWTbLv?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d37ce0-321a-42ac-0ec7-08de80576ced
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 16:50:11.1808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DLa0caePLL7zZF1H6s0WvF10/merMJ6BTioQ+s5n2fKFznSgsgBDa/irpXO9+SKvQWNF2xpDDJfOzVviUHur2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2018
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9397-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,google.com,lwn.net,linuxfoundation.org,kudzu.us,intel.com,gmail.com,tkos.co.il,baylibre.com];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1277F2760D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This series lets an endpoint-integrated DMA engine be consumed on the RC
side through vNTB.

The initial target is DesignWare endpoint eDMA. pci-epf-vntb exports a
versioned DMA locator plus the minimum peer-visible resources,
ntb_hw_epf parses that locator and instantiates an auxiliary device after
LINK_UP, and dw-edma-aux binds to that child to expose a DMA engine
provider on the RC side. ntb_ep_dma is included both as the first
consumer and as a simple bring-up test.


Background
==========

I previously posted a broader RFC series:

  https://lore.kernel.org/all/20260118135440.1958279-1-den@valinux.co.jp/

This series is not a direct continuation of that RFC. Its scope is
narrower, and the approach has changed substantially.

That RFC had two architectural issues:

  1. dw-edma-specific logic lived under drivers/ntb/hw/, even though
     the exported DMA engine is not related to any NTB hardware.
  2. Remote-use channel delegation relied on vendor-specific peripheral
     configuration.

This series builds on the recently discussed pci_epc_aux_resource work
(see "Dependency" 3 below) and addresses both issues by:
  - introducing vendor-neutral DMA-channel delegation in the PCI EPC
    layer via pci_epc_delegate_dma_channels() and
  - making vNTB and ntb_hw_epf aware of the remote DMA resource.

On the EP side, pci-epf-vntb describes the exported DMA resources as
part of the vNTB BAR layout. On the RC side, ntb_hw_epf detects that
export and registers an auxiliary child device. A vendor-specific
frontend can then bind to that child device and reconstruct the remote
DMA provider. This series includes such a frontend for DesignWare eDMA
in dw-edma-aux.


Architecture
============

  EP kernel
    pci-epf-vntb
      - exports the usual vNTB control/db/MW resources
      - optionally exports a versioned DMA slice

  RC kernel
    ntb_hw_epf
      - parses the control layout
      - instantiates an auxiliary child for the exported DMA ABI
    dw-edma-aux
      - binds to that child and registers a DMAEngine provider


Series layout
=============

  01-05 prepare dw-edma and auxiliary-resource metadata
  06-10 export delegated controller-owned DMA resources through vNTB
  11-13 discover the exported DMA instance on the host and bind
        dw-edma-aux
  14 adds ntb_ep_dma as the first consumer / smoke test
  15 documents the model and the configfs layout

I did not split the infrastructure patches (01-13) away from its
consumer (14). The series is meant to be reviewed as one feature:
producer, discovery, consumer, and test coverage.


Test
====

Tested on R-Car S4 Spider with the dependency below.

  1. Configure and start pci_epf_vntb with DMA export enabled.

     The actual commands I used for testing:

     # modprobe pci_epf_vntb
     # cd /sys/kernel/config/pci_ep/
     # mkdir functions/pci_epf_vntb/func1
     # echo 0x1912 >   functions/pci_epf_vntb/func1/vendorid
     # echo 0x0030 >   functions/pci_epf_vntb/func1/deviceid
     # echo 32 >       functions/pci_epf_vntb/func1/msi_interrupts
     # echo 16 >       functions/pci_epf_vntb/func1/pci_epf_vntb.0/db_count
     # echo 128 >      functions/pci_epf_vntb/func1/pci_epf_vntb.0/spad_count
     # echo 1 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/num_mws
     # echo 0xF9000 >  functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1
     # echo 0xF9000 >  functions/pci_epf_vntb/func1/pci_epf_vntb.0/dma_offset
     # echo 4 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/dma_num_chans
     # echo 0x1912 >   functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_vid
     # echo 0x0030 >   functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_pid
     # echo 0x10 >     functions/pci_epf_vntb/func1/pci_epf_vntb.0/vbus_number
     # echo 0 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/ctrl_bar
     # echo 2 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1_bar
     # echo 2 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/dma_bar
     # echo 4 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/db_bar
     # ln -s controllers/e65d0000.pcie-ep functions/pci_epf_vntb/func1/primary/
     # echo 1 > controllers/e65d0000.pcie-ep/start

  2. Boot or rescan the RC side and let ntb_hw_epf probe.

  3. Load ntb_ep_dma on both EP and RC.

  4. On the RC side, run the test as follows:

     # cat /sys/kernel/debug/ntb_ep_dma/0000:01:00.0/ready
     # echo 1 > /sys/kernel/debug/ntb_ep_dma/0000:01:00.0/run
     # cat /sys/kernel/debug/ntb_ep_dma/0000:01:00.0/result

       last_status: 0
       last_len: 4096
       local_buf_dma: 0xfffff000
       local_buf_size: 4096
       peer_ready: 1
       peer_state: pass # <----(*)
       peer_dma: 0x4e11e000
       peer_size: 4096
       peer_seq: 1
       peer_xfer_len: 4096
       link_up: 1

       (*) The peer reports "pass" after the transfer completes successfully,


Kernel base
===========

pci.git endpoint:
Commit 0b74f7d72399 ("PCI: endpoint: Propagate error from pci_epf_create()")


Dependency
==========

1. [PATCH v4 00/10] PCI: endpoint: Differentiate between disabled and reserved BARs
   https://lore.kernel.org/linux-pci/20260312130229.2282001-12-cassel@kernel.org/
   https://patchwork.kernel.org/project/linux-pci/list/?series=1065666

2. [PATCH 0/2] dmaengine: dw-edma: Interrupt-emulation doorbell support
   https://lore.kernel.org/dmaengine/20260215152216.3393561-1-den@valinux.co.jp/
   https://patchwork.kernel.org/project/linux-dmaengine/list/?series=1054298
   Note: already landed in dmaengine/next.

3. [PATCH v10 0/7] PCI: endpoint: pci-ep-msi: Add embedded doorbell fallback
   https://lore.kernel.org/all/20260302071427.534158-1-den@valinux.co.jp/
   https://patchwork.kernel.org/project/linux-pci/list/?series=1059820

4. [PATCH v2 0/3] NTB: Allow drivers to provide DMA mapping device
   https://lore.kernel.org/linux-pci/20260306031443.1911860-1-den@valinux.co.jp/
   https://patchwork.kernel.org/project/linux-pci/list/?series=1062308
   Note: this series uses ntb_get_dma_dev() API.

5. [PATCH v2 00/10] PCI: endpoint: pci-epf-vntb: Document legacy MSI doorbell offset
   https://lore.kernel.org/linux-pci/20260227084955.3184017-1-den@valinux.co.jp
   https://patchwork.kernel.org/project/linux-pci/list/?series=1058871
   Note: v2 title was incorrect. See my reply to the cover letter.

Additionally, for ntb_ep_dma test to pass on R-Car S4 Spider:

6. [PATCH v2] PCI: dwc: rcar-gen4-ep: Mark BAR0 and BAR2 as Resizable BARs
   https://lore.kernel.org/linux-pci/20260210160315.2272930-1-den@valinux.co.jp/
   https://patchwork.kernel.org/project/linux-pci/list/?series=1052780
   Note: already landed in pci/next.

7. [PATCH v2] PCI: dwc: rcar-gen4: Use 4K EPC BAR alignment
   https://lore.kernel.org/linux-pci/20260305151050.1834007-1-den@valinux.co.jp/
   https://patchwork.kernel.org/project/linux-pci/list/?series=1062031


Merge plan
==========

This series touches three areas:

  - PCI endpoint core and pci-epf-vntb
  - DesignWare eDMA (dw-edma)
  - an NTB test client

The series intentionally keeps the infrastructure changes together with
their first consumer, the ntb_ep_dma test client. Splitting them further
would leave the infrastructure patches without a consumer, so the
patches are kept together as a single series.

Mani is a maintainer for both the PCI EP and dw-edma. My initial thought
was therefore to collect acks from the relevant subsystems (PCI EP,
dw-edma, and NTB) and have the series applied through the PCI EP tree.

However, I am of course open to any suggestions regarding the preferred
merge path or series split if maintainers think another approach would
be more appropriate.


Best regards,
Koichiro


Koichiro Den (15):
  dmaengine: dw-edma: Cache DMA channel IDs in dw_edma_chip
  PCI: endpoint: Add DMA channel metadata to pci_epc_aux_resource
  PCI: dwc: ep: Report DMA channel metadata for aux resources
  dmaengine: dw-edma: Add per-channel interrupt routing control
  dmaengine: dw-edma: Compose MSI messages from allocated IRQs
  PCI: endpoint: pci-epf-vntb: Fold MW runtime state into a struct
  PCI: endpoint: Add EPC DMA channel delegation hooks
  PCI: dwc: ep: Delegate exported eDMA channels through EPC ops
  PCI: endpoint: Add pci-ep-dma helper for exported DMA ABI v1
  PCI: endpoint: pci-epf-vntb: Support DMA export and shared BAR layouts
  NTB: hw: epf: Parse control-layout version and DMA locator
  NTB: hw: epf: Enumerate auxiliary child for DMA ABI v1
  dmaengine: dw-edma: Add auxiliary-bus frontend for exported eDMA
  NTB: Add ntb_ep_dma test client
  Documentation: PCI: endpoint: Add vNTB DMA export HOWTO

 Documentation/PCI/endpoint/index.rst          |   1 +
 .../PCI/endpoint/pci-vntb-dma-howto.rst       |  83 ++
 drivers/dma/dw-edma/Kconfig                   |  11 +
 drivers/dma/dw-edma/Makefile                  |   1 +
 drivers/dma/dw-edma/dw-edma-aux.c             | 297 +++++++
 drivers/dma/dw-edma/dw-edma-core.c            | 101 ++-
 drivers/dma/dw-edma/dw-edma-core.h            |  13 +
 drivers/dma/dw-edma/dw-edma-v0-core.c         |  26 +-
 drivers/ntb/hw/epf/Kconfig                    |   1 +
 drivers/ntb/hw/epf/ntb_hw_epf.c               | 199 ++++-
 drivers/ntb/test/Kconfig                      |  10 +
 drivers/ntb/test/Makefile                     |   1 +
 drivers/ntb/test/ntb_ep_dma.c                 | 695 +++++++++++++++
 .../pci/controller/dwc/pcie-designware-ep.c   | 196 +++++
 drivers/pci/controller/dwc/pcie-designware.h  |  11 +
 drivers/pci/endpoint/Makefile                 |   2 +-
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 794 ++++++++++++++++--
 drivers/pci/endpoint/pci-ep-dma.c             | 342 ++++++++
 drivers/pci/endpoint/pci-epc-core.c           |  84 ++
 include/linux/dma/edma.h                      |  42 +
 include/linux/pci-ep-dma.h                    | 130 +++
 include/linux/pci-epc.h                       |  31 +
 22 files changed, 2981 insertions(+), 90 deletions(-)
 create mode 100644 Documentation/PCI/endpoint/pci-vntb-dma-howto.rst
 create mode 100644 drivers/dma/dw-edma/dw-edma-aux.c
 create mode 100644 drivers/ntb/test/ntb_ep_dma.c
 create mode 100644 drivers/pci/endpoint/pci-ep-dma.c
 create mode 100644 include/linux/pci-ep-dma.h

-- 
2.51.0


