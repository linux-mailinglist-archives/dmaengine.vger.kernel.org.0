Return-Path: <dmaengine+bounces-10596-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJFFCKOnDmr6AwYAu9opvQ
	(envelope-from <dmaengine+bounces-10596-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 08:35:15 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DA759F7A4
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 08:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 067D0300363B
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 06:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F4D1C3BFC;
	Thu, 21 May 2026 06:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="hQjVecAe"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020112.outbound.protection.outlook.com [52.101.228.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1926E318EDF;
	Thu, 21 May 2026 06:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779345083; cv=fail; b=T7faKKNx/DducZLKdR4P1sejPQkhIl0bvymbJyfFoc+P7enmhOk1BSSbL/b490iLiVo15mGbs1JgIowwbULarGhp6386aoH8bfu0nu4sTMNAHeBXdsSkfNbUOhB0cu9+3ae3VtdIHL/NYVuejn4HMeCYvMb/3vJN4bmcTbJjJao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779345083; c=relaxed/simple;
	bh=oduBtskGtJjUHQ3SzqNCtDxHz2eLxnAHAXNVU8UQ7ho=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sPflVfFFUiPEiDstvBdnXQSlt8hhB9mdvZqtCI7ro64ullcTF1Sj27IJBRUaP2tLumI+rP8C5KGdO7LabOpZ4TGZRGYz9JwKqMoSXDLPXMXE3I+SPoQlhLhDWEoxTUyv6aqX6Jns/bvwbhbO2cwl0JHto7Kcc2MmR7VHIvnllMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=hQjVecAe; arc=fail smtp.client-ip=52.101.228.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dKlm2+t7Ah5BKMFuUmTvc2BUJuFdqzdHsc8+y62wXMabbOpnAzp6Sp3YhwCxnghH3WopFXVKOspnUri/HE5jBk4nJyMjZH6D5YDjQYlmF3rI5fg44xw4xNM1lOoU74QJNwNcRRWrSwQbWANItN/bgCfhlh9QiExXaWSNkpGKpcKGZgObNnfmFhJYiHJdbVo8IzfoW6sHG00rfZXikFGI7iqPTuKTP3iT6Ir7zblfHGvelZmBHDkFL5xZjGzvo3rdUJXVodmQmrOjzdo1nhRLJPfX2iu31F2mqG+G3gyQlOecFQc9/vTkx/kjdGNMcQtlUSBVAwj8dqStHfMbGblJAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxVDNWsld19NLQoT33Jz6sP+2/uhVBT57H3y2NeTscY=;
 b=ZVaqXqoi/ZnLNhD7wT2WvaQfkiBttGS1flykZjlDI45zYSxGsCi93zTq+0NUaBqhulvplruGIJY3/Yp1nuJHVrexaOHbwYTcXTHSqYpARmvetnU8K838fIhcYSdDxgwroGs07akkQQkcRD54rV6xfLXd7jtzkhGInFoPP8F06lERbwSbsITNHkOrC0EAfZ2oOwP0lprDHXYiiCSYKt0TUUy06Q5HdOKWGVoZP0Dj7aRm5Cjz7X5mSe56EcDJZl42PSWq1fzstA6qRTpxK68VFcyt7wgEe38o1GF/2ZQWcS98kLJhQbDDpXcEaJ3+Fnu4w95RaSEY516+Qi880sEwDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxVDNWsld19NLQoT33Jz6sP+2/uhVBT57H3y2NeTscY=;
 b=hQjVecAeQv0/ydczrL6GbdFAU0La47gFcEH8vIoKGZJ0V7Wajy/18bGyEsdyJYZIlbEcfsfi+/8E4n1RptMfNXmRxuMn/KkYpzMvq3aVFaPqi8wzxIgHoblI6xTjUmlKLB+H2YZAGcWj9+0fTnR3xt16D8h2XMRbywUw2KsjxRY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB7818.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:473::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 06:31:19 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 06:31:19 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/12] dmaengine: dw-edma: Prepare for PCI EP DMA (part 1/3)
Date: Thu, 21 May 2026 15:31:03 +0900
Message-ID: <20260521063115.2842238-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0183.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB7818:EE_
X-MS-Office365-Filtering-Correlation-Id: a25c427d-fa14-4467-a0e6-08deb702919c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|18002099003|56012099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	0cVrjaXr5bKac81iAZJEW+VCCOoR3p4n+1uiGyEutlobPGN/bgULU/HwFe0bBgw4Fk4T8Lo+C1AI/B4hJySJbegy9Y6B4Sh+yZveFFmufg6rXDJ7XumyaJKtzFLBEgFIIewalbgdLUawq5rvMsCn0qwe1om7BOCCI4Yl3+YkkgbNOGT2459/sBMhqeE6lAT/wukLcfCrPjsWm4GKW/SiR8KjussFXM2bjWXqpuZg9bk5gm1Jb7GZUPZnArOcNUkgzKqPqex344ipNAjWslqu5CTJsiSSP4b6hmLVDpufbco5EIoWD2RGWeldExDe0JEGWcJiwFCFygl5nOo9QLghzomtiwgRXh0V0M0oMmJ48Iab6FJ/YeoVos6EB7HnumhemhIc2Fc2+ZgLgxQ643x1MwIaCC9HGLyPW8Mf8gJuPxvJIrS1ZBXPxoYaqbdqSxZO/+XFAkbJs6/EAXY1cSltNJ2JJQaQTy/j8AuQZowS9pN60xkk2Dsclyg/TMFMZfAAp1TjdRgUz1e5KjYFuKy/03njTt+IpQlNdKXsHnQ0segdDQbrC46pZ5PntxrtBF8ga4JgKsaogRqjbUdY3Qy9AFKbSm2FsI5ZBKE6IhKJPlGLxHmIygxsUp7ykt7XHzB1I2IJ+JIos7FsEjPI3jQSZMQ6oQcI0hSRjwvX79/YESvnTqff9xKepBwEygZd8w90UJtrkz/AWagyGgGLQ2oHTw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(18002099003)(56012099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NWx6/njBpkkyoTIZP7HYoLVtQJW0SvrFXV6cce8XXrfSUiM1rWuDdmIHdg/C?=
 =?us-ascii?Q?LU29h7fmWq/U2iga8fA/PswBFzW4P2IYst6gbpXF7exnXm6yKK+VqsjIGuEh?=
 =?us-ascii?Q?z3Qwz0jXoJ2i4/pseWTKJlw5EJA2zP9OFnZfax4XCgXEhLUjHaPr0h1n4nUD?=
 =?us-ascii?Q?LGPlqv7XbZ/cyb7xqg/ZYkSLrSPJcODetb0q2cRHoc68QI+2b92WsTpPPvch?=
 =?us-ascii?Q?qxaJzlBk/GFwiJ2BbMxZmLHdtpqsZpDLU6+ZyIiy+SYru/eGnOvlImdewmZH?=
 =?us-ascii?Q?t6kDHTl8B/PRjPHV917jLEELXF3eCqnEceZu3fLZDHmTWHDmQwBezd/XAOpc?=
 =?us-ascii?Q?aNbRewJYLjMMxTbqIGKP+P3b3rLOvYxJGU/wJbHeojUF1LlCBjyx5KFczHTC?=
 =?us-ascii?Q?xxcVrRIUT6QgrHHO2Pc3wSAa+pCrfB6lP5gD6Dx5K4NgntPI2nhRqdPiemyU?=
 =?us-ascii?Q?K9mG5C3T6L6msbEjDqWStYc6i7nngu3knrwDPy2TeF4a4YHMMRPVuIGNE2XB?=
 =?us-ascii?Q?IfnvJ52o2KZ/OLs26xo7dni1EgyA0EAhhWh2XLDJ55giQlmv0VIdxt94XY3f?=
 =?us-ascii?Q?KT77Ld3+UsblW4I0IYuaGNE+mcyMqltl2JkI2eCy34vow3KHHBZdzS9CAr8Y?=
 =?us-ascii?Q?eEe5Cw/6NyMXp5utcLm0G++zX8bndTQ17KbdPrxMgWr4dhQZ3sRwhrk+4taJ?=
 =?us-ascii?Q?+GbD7fnJtEuc/mrhLKXcOulH/tt2S6UHgv5ffoMygF/ktuFM67RXG/PbhbM4?=
 =?us-ascii?Q?xNlOiDJBLeJyYfds/o4k4WxJNdth7rvkiv90rRAxv7IpHrgVuo61nq1rpl50?=
 =?us-ascii?Q?8egOwYwJ/zaqHG1hiequhrHpDkUm6minVNlvEUyLp39/JEsGie2RtP+3uCeg?=
 =?us-ascii?Q?oqF11Lc3H3Qz6YwOY3aS771xVeXu+fK/yWeIrwHYrgTg2AGPtkjBerAPXIA3?=
 =?us-ascii?Q?+DCcOnMprs6eGOa0r+IwW29YN11bEXp1V4PiMdgGenvD2BoGSSQAkLCtsbBd?=
 =?us-ascii?Q?dlYagrNhsqbS2YOMpHcT0/vTf+oSiacGlrV2FTFse7jB+HO6TFsGHFrDetks?=
 =?us-ascii?Q?BRL4tWfZkqblfy1a3ZDeNwJg81b4ygMi3E8WI516xKxS21u+0sBgf4q4gPHE?=
 =?us-ascii?Q?1g1Ss6rHUqbYnetlgRtJDbIv9XgAPGAzGCIgVbB5Mu144wSli5DY80fjIVC9?=
 =?us-ascii?Q?Ifxvr6NTkYRgUW/Rp5q5hb5H3yKsuX2huAEfn36TB/LK7ZYIhRNdWZZeX9ls?=
 =?us-ascii?Q?NclHMBjsloTKmpU9JHlQ+pL/KuEtN7aZGzEOUbPvVS8AbOjVOeA77IuZTYTi?=
 =?us-ascii?Q?9/lNFZSNeN+Q/GKmIORYejsoqrvLO6Z1KV9tuhwMqT/Ukgq2BN1Gcn4/ieb0?=
 =?us-ascii?Q?dcyYOXjwbGrRbkjb2Pp+OjWiD9IblAMbTVQfZrnz9dqncNPey2KD2MKOXXuU?=
 =?us-ascii?Q?UM80Ej76Q1tXF2G7ndwdTztuoM7BEUT+IFXJo4tKtHlZz1poS0a2L7SHOax+?=
 =?us-ascii?Q?SPy/zFzv9x1au2HpVBQAbr2FhWbL9yaFPWqTfsDPOCpJKuhM70KwhKQxj5zL?=
 =?us-ascii?Q?xEDwbJwxkYXGA9tn6fjwkSvCNIF5oeFHd08DLL+mwXfF9E+UY48CDv2kS7Cg?=
 =?us-ascii?Q?EXKQpgsalGCelCXjGmXpXyPtc5D951ukAOQMk+ASBvj4Ry6URo1u9XUJzKRR?=
 =?us-ascii?Q?9zFTS1dw+Xo2h5XE+9dVJLBUWPyJ47UgFRSsNO18Y3nWv9ceIoHAYScaMA1i?=
 =?us-ascii?Q?QYe0j0V+cLJ1Cm3xoRu2Qq/cZRfpGkabhTPhmdn+eH1/5y4ALDRL?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a25c427d-fa14-4467-a0e6-08deb702919c
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 06:31:19.4671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tRPA3HsCEiuEGvHfykqWGpp2I+KR0AtApEi5woahRo7W4wCtlbv2phSpzfEhkHeHkfpFul1xelU80Nkmdwyi3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7818
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10596-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,valinux.co.jp:mid,valinux.co.jp:dkim]
X-Rspamd-Queue-Id: 49DA759F7A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This is part 1 of three series for PCI endpoint DMA.

The three series are:

  * part 1: dmaengine: dw-edma: Prepare for PCI EP DMA
  * part 2: PCI: endpoint: Expose endpoint DMA resources
  * part 3: PCI: endpoint: Add PCI DMA endpoint function

This first series contains the dmaengine and dw-edma groundwork needed
to let a PCI endpoint function delegate selected endpoint-integrated DMA
channels to a PCI host. It does not add the endpoint function itself.


Background
==========

I previously posted this RFC:

  [PATCH 00/15] PCI: endpoint: Remote DMA support via vNTB
  https://lore.kernel.org/linux-pci/20260312165005.1148676-1-den@valinux.co.jp/

That design exposed the endpoint-local PCIe DMA engine through
vNTB. This version moves the DMA engine into its own endpoint function
instead. The host then sees a DMA controller PCI function, and vNTB does
not need to carry a DMA-specific ABI.

The immediate motivation is NTB transport between a directly attached EP
and RC. The goal is to use the endpoint-local DMA engine and avoid the
extra CPU copy in both directions.


Scope
=====

This series:

  * makes dma_get_slave_channel() available outside dmaengine core so an
    endpoint function can reserve exact channels before delegation,
  * adds dw-edma helpers for channel lookup and per-channel interrupt routing,
  * adds a partial channel ownership mode for delegated channel sets, and
  * prepares dw-edma-pcie to describe device-specific DMA layouts through
    match data.

The PCI endpoint metadata format, DesignWare endpoint resource exposure,
and the endpoint function driver are added by parts 2 and 3.


Dependencies
============

This series is based on dmaengine/next at:

  362ee0c0dc52 ("dmaengine: Move MODULE_DEVICE_TABLE next to the table itself")

Parts 2 and 3 depend on this series.


Best regards,
Koichiro


Koichiro Den (12):
  dmaengine: Make dma_get_slave_channel() public
  dmaengine: dw-edma: Add channel lookup helper
  dmaengine: dw-edma: Add per-channel interrupt routing control
  dmaengine: dw-edma: Add partial channel ownership mode
  dmaengine: dw-edma-pcie: Add capability match data
  dmaengine: dw-edma-pcie: Rename DMA data copy
  dmaengine: dw-edma-pcie: Add default IRQ match data
  dmaengine: dw-edma-pcie: Add raw slave address match flag
  dmaengine: dw-edma-pcie: Add register offset match flag
  dmaengine: dw-edma-pcie: Factor descriptor block addresses
  dmaengine: dw-edma-pcie: Handle optional data blocks
  dmaengine: dw-edma-pcie: Add chip flags match data

 drivers/dma/dmaengine.h               |   1 -
 drivers/dma/dw-edma/dw-edma-core.c    | 134 ++++++++++++--
 drivers/dma/dw-edma/dw-edma-core.h    |  13 ++
 drivers/dma/dw-edma/dw-edma-pcie.c    | 240 +++++++++++++++++---------
 drivers/dma/dw-edma/dw-edma-v0-core.c |  26 ++-
 include/linux/dma/edma.h              |  52 ++++++
 include/linux/dmaengine.h             |   6 +
 7 files changed, 369 insertions(+), 103 deletions(-)

-- 
2.51.0

