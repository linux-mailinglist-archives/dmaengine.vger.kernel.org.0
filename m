Return-Path: <dmaengine+bounces-10807-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGMZGCzrE2qoHQcAu9opvQ
	(envelope-from <dmaengine+bounces-10807-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:24:44 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DC15C65C2
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 800B830011BC
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 06:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498E3399CED;
	Mon, 25 May 2026 06:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="f0f0UqyL"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020141.outbound.protection.outlook.com [52.101.229.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6CC31E83E;
	Mon, 25 May 2026 06:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779690278; cv=fail; b=jgNQ//+L+Pwgwg7BlScnRHJd1DkXITPymoZfspxx7AkUN3lkkP8EyatyXocHAt0COWIpJUPPU85mUN5Y0iYnnRiU0l78ykNMXg+DMZAJwWLOVwJAHkn6YYAitV8uPDM6O3V1InaYYvUeN93qDgerd5bgp/ieH7oD9ASTiXUaX5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779690278; c=relaxed/simple;
	bh=fhFGlbBok96R6f4TezX0NR45x6BKOLeA6kip9tTcm1U=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=S05qNkfX24UEkC/dcWTPOqrZxaxYCZZ1azRjQhLXuiQ9ubAvPQzq8smkwXgZqa89ckLVrYJHKFCMrn3BmncHwII73Yg54HYpsVlXJK8oVtNHIvPtuEQfiCEpftFFUykCp49TUftzSMnc68ni9DxAn5H4i5BRXdwiRvIdkqHZDBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=f0f0UqyL; arc=fail smtp.client-ip=52.101.229.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ERch5wfPbslc56lxMDcqVWogpgsvggO8hrrhvLxqufIyi0K0189vFic3tiN6siRRTW8RbLp2+sc3Sa2uuxOEODjZOl77nl0bExXUDm9lkvuN8QG/2D2Q0TWo91KHURybMYyvLFpHvIf6g/Zbs2eu33mpwDPpKWR35izIER/sMZtvNLWWMnBpflkhnZHG+vR2KKLqhoIVqcJpB8dKcyHtVMgXNyG5+LREG3pDYzY6q9a83ZIq6Aq4cNwc3OTKSvRaH5xCzghvEcOM8zu/8khDOCj6DyH43KZSqDov8eZ9NXfRnuE0lu0XfEviuWkKECgpkt/DYedG0d5VCCFwGO/rRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsGZsIBYLM1Z3caBGw2vfHgXPPcygYkvVEulkhzfDxY=;
 b=S0pIfT/KtV+jom2/012eBeAivcBuQj20z9cID5zhYGhUTM9Y0tFg+r4dGljPj8HMv8aorBJMh+ZMgFYIwcan/HsGm1EoYoayTnMiaM7X+4WWtaXNbNHXCiG+UeUH0UU+WhpBq6zB+0JpqZ3XXq07acsje1JV4rpmw/JQFlkQTkHBdwCviNq2o/+ITUezv1fOVL0KbuBRvtLmVsUiFaQOG87HDQuba1qQOl7kyIfjCP82KiWLJH2FP2MAmtQdRNJIhDaJ0+0bJxh2FLr/M+BElaIIsUQ8pkXGK1hzXTt1xmmQnLjBqB9TV+zoOPJTpvoJotbn2AHiw81BWhtnUX0WRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsGZsIBYLM1Z3caBGw2vfHgXPPcygYkvVEulkhzfDxY=;
 b=f0f0UqyLndnv1DX0CoZoITUL9ne8lNGIeDeHqvrsTGWIRI4FY/shqH0ELIJAUPABNW5E+VQOMmkddFaFPKSgbCE7v/zunkBwaTv602dThJFAHdS04QOHBwel9Qnw27uVJcXTz+40P+G4kc02f3/2w2S0X5LBw1PgGisEGWOIi+0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB4655.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 06:24:33 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 06:24:33 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/12] dmaengine: dw-edma: Prepare for PCI EP DMA (part 1/3)
Date: Mon, 25 May 2026 15:24:08 +0900
Message-ID: <20260525062420.3315904-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0341.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB4655:EE_
X-MS-Office365-Filtering-Correlation-Id: 28fe61a7-82b0-4b93-6a22-08deba26491b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|6133799003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	IGYPxThHpUneqRzBYlbeC8JA7yX6jHAblzsPqTnjHEUebQVU8n7MX9bdp8B8wYEMPnpEqmKI5xv0lvI5rOEpkCj+ZbfELic44L/iM1jmMbFrykmbMQzrsJtBhJ4F/J06nLx32kzilQvy7jsbVes6WzHiK+jSHGrvEzPFr208pfnYhNHwiOvI7aVQA2s5IAboHYwoFMpqRljxtctUgVMmU8kvITWIWHjmKSD+qhQS+xMPIVDMmEj4y2hLzbl7gafjvbh8SXNFk8Hdx1ZucQPGPMo4wVnuICmPMJPia+T4vzKyDW0BTeUq8RV1E7Hxx0lq+Wby7BC7mWdOY0aA7vN22Viz68oMLDGKJfu1YgArMK2hbmoxlA47zPszfw1LDqyolqpxPM6BxxdA1ukMoNmTivMTBNWonOPovE5g4wuj7PDLBzCNnTngvyYN42p3exkZkfQQYQYAvYUZnYbu0GVfZUSZtuUIiKWSuRU4TR6BBjk7UXbpNQzSV8cAXmhl6/Ol0E+wUobPhumg5EHGc5yJ86pkCjun2hAtHYijW2Y2CbWowwBbLhGPMIkQIw/1YnhVu4CALbf4RgCFvjZfoZEz9euc+Ovd4NzNMpUA1o8san7MKSIek6Jcmix2K8YiqPYp9lp78TVWrfWhff/z+BnPVwEJ7hJ/21/t0TyjtKeabuRE6b3LOGClonbXS+fWu5OIscPENGJ/zxCdiIlgzJdtYQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(6133799003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PhHYaMwoNUzUFj+mTTQ7IJtzSA0ByYAXFTCSDSEA5yboEs4vRuxk6nrunkqj?=
 =?us-ascii?Q?0hKgvWyPM0a0E+tvwE4KZvsvu3236c8waSmbN46EHTmkSZ15Mpwv6+gTbBxw?=
 =?us-ascii?Q?uyyJl7ESPuLUndjdQgrObI2RJDZpJSO3DskLL+UvZtkyqBYaRwLXglCeWRwo?=
 =?us-ascii?Q?u5/W9gI89Tkj5amnc+4JINlkfsXmGx5UCCCcsIkpJJIKdEyexh2a67SS4r4Z?=
 =?us-ascii?Q?BqEg4piXjVYHRT7inm+I5xSmA5MfiZGaOUP96cDDwzrqoKhDKKkZ0hwQmBY+?=
 =?us-ascii?Q?yTCxE4ESlrI4wzbRHyWgL12t6BTjgIi7KxCPOaYt5XMWIATSsV+hlEtaG8iS?=
 =?us-ascii?Q?H+XvbtrHBhaQrawZLsCEzuqYKKqeM+KjARGaEv7h0OuOkMQxIN853ZY0xS2M?=
 =?us-ascii?Q?pbZtY9Wp+lXw22f399g55Kgqb6+HFb/zvOLcsmWjaw3B7EezihUjMzw6eGGh?=
 =?us-ascii?Q?V68aNcZVIAHHWrPHyob+Mjvke0fuxh3SgTz5lgHcM5ykczcbo1C+pUZG/o6n?=
 =?us-ascii?Q?VkENJDFUL0v6myY+q9hKRaNN3LSpeQ1o+b8i8Jk6ywJumccy2ItpWUWtEB9C?=
 =?us-ascii?Q?NvfFS6nMNUGYwWPD57VfhuVJMOoM8zmEYx63It6MIFXWW9o9xCWlLb8JqFXU?=
 =?us-ascii?Q?BhBXVFL3F01cR0KlexEUbKhKY3IGXsFHiKSlAnC3gA0tqhZbXivqCkBh6XH4?=
 =?us-ascii?Q?kpjfTHwjzIk24TiAHmgKXYVbdEDYSWCAG3WhQCr5xIpgl/5YfoVqTl0U0FDv?=
 =?us-ascii?Q?YVgDyigK0JddTGw9kuCMrRgN+o6w2EKkWvdpe+V4Au7Mp/iEFYomxQdJkQVE?=
 =?us-ascii?Q?kB51AiHBRDYeWu2EEUA2WdyPSgKiODiwUed/pCvuV2+q4ljqWylLcQ9iV/bB?=
 =?us-ascii?Q?l7LFrzNzFNutTHcjifj5a0VL2FvL2A/9JdpHVK3z1pS7xrDwRrlMN4K9GvtB?=
 =?us-ascii?Q?+WOzS5ifvzc2oNfl06XBI6N5kVsKLaghVSP3K/qRVQXIQth3FDIDtIZqxaKM?=
 =?us-ascii?Q?koDpcIRA8nw4zQCc1GwCM2ZKDNU8EOnLR9OyaZHVQ7qEGIls85pQnBTWRwJ6?=
 =?us-ascii?Q?NwTnWoY2g61oEoLI32N7xR4kZw9hg8ISOCbjF97C8H1BfLnWi1IRjDQXR7ct?=
 =?us-ascii?Q?iDzXjtyqOwQqW1lZYPYf3iW3FGMtKc/ZVIIO1K8KtOibrDvre4yFhkKdpywZ?=
 =?us-ascii?Q?46xj0cqpQxFTDTbfa9QWo245+wJ3XGhvokPfyADvMIcQ4cot1681/rGe6uXH?=
 =?us-ascii?Q?A2xmwcwYo1wbZZZ+0t90lueFzyybmDFKcgA4tSoV7AU3FkeWsJ3eZ5bpagy2?=
 =?us-ascii?Q?qIgKjpoRm6ruiX7JxnJ4g7Vmfu6k2mAhmgyaH6d3FQ8huTnpewRQpeXNX80F?=
 =?us-ascii?Q?uBKgnxnbtTs0qWgM4dbbauuww96HOIYqA8jclOePcbBNGuvdU1/+GR299IAt?=
 =?us-ascii?Q?bW1PUy687r8JOf+LaSc/ldy0ghRnGkPWSQGMwT586gUqRw/kYfZJ9T0W+eC3?=
 =?us-ascii?Q?rxM8MkI/EkhG2qc1LVxDKuQKpMIHG0NMtzJQQJzkM9LUt8tveYmbAWGx3URr?=
 =?us-ascii?Q?NSOdOgAvTQRxvAyP9TGK6CovTySCm36zL218peVI9VVrG1uEA8a9Cm100H//?=
 =?us-ascii?Q?fQo1PCLInPBV1+5+jtTZQiuhIEtgazPNO1H9rBg+BDZg4WXGFt54FoOceDqw?=
 =?us-ascii?Q?ouGlETf1He5IYytzhIs8+Y6lDDCBa+yJLfGoGHJCrKDyJhbnUatnZbkfpWSL?=
 =?us-ascii?Q?agZ8MifzXr+FwJIy2+8hYmxYFlTapK3H0GXb+eEKOM0IoxKW37fi?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 28fe61a7-82b0-4b93-6a22-08deba26491b
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 06:24:33.1993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Al/mZFMkWVwCcYH/PtqvQYJduJPn+Obtu87WOEzbjQBjHxv6En2iICh3bUOrVTsYqnAWQCLlrhZ6sGjcUTKpRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4655
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10807-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:mid,valinux.co.jp:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 67DC15C65C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This is v2, part 1 of three series for PCI endpoint DMA.

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

  * adds a dw-edma dma_request_channel() filter for exact hardware channel
    claims,
  * adds per-channel interrupt routing control for delegated channels,
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


Note
====

Pre-existing dw-edma issues flagged by Sashiko during v1 review are
handled separately. See
https://lore.kernel.org/dmaengine/20260521142153.2957432-1-den@valinux.co.jp/


---
Changelog
=========

Changes in v2:
  - Move non-LL state and platform ops into match data. (Frank)
  - Use a named .driver_data initializer for the Xilinx MDB ID entry and
    fix the vsec_data rename patch title. (Frank)
  - Replace the dma_get_slave_channel() export with a dw-edma channel
    filter for dma_request_channel(). (Sashiko)
  - Rework the IRQ-routing config as dw_edma_irq_config, keep HDMA native
    int config separate, and reject remote IRQ mode on local instances.
    (Sashiko)
  - Report IRQ_HANDLED only for status that was actually serviced and drop
    the lockless free_chan_resources() reset. (Sashiko)
  - Tighten partial ownership: reject unsupported map formats early and
    require direction-wide ownership for supported shared-register
    layouts. (Sashiko)

v1: https://lore.kernel.org/dmaengine/20260521063115.2842238-1-den@valinux.co.jp/


Best regards,
Koichiro


Koichiro Den (12):
  dmaengine: dw-edma: Add hardware channel filter
  dmaengine: dw-edma: Add per-channel interrupt routing control
  dmaengine: dw-edma: Add partial channel ownership mode
  dmaengine: dw-edma-pcie: Track non-LL mode in DMA data
  dmaengine: dw-edma-pcie: Add capability match data
  dmaengine: dw-edma-pcie: Rename vsec_data to dma_data
  dmaengine: dw-edma-pcie: Add default IRQ mode to match data
  dmaengine: dw-edma-pcie: Add platform ops to match data
  dmaengine: dw-edma-pcie: Add register offset match flag
  dmaengine: dw-edma-pcie: Factor out descriptor block address lookup
  dmaengine: dw-edma-pcie: Handle optional data blocks
  dmaengine: dw-edma-pcie: Add chip flags to match data

 drivers/dma/dw-edma/dw-edma-core.c    | 128 ++++++++++++--
 drivers/dma/dw-edma/dw-edma-core.h    |  13 ++
 drivers/dma/dw-edma/dw-edma-pcie.c    | 245 +++++++++++++++++---------
 drivers/dma/dw-edma/dw-edma-v0-core.c |  22 ++-
 include/linux/dma/edma.h              |  64 +++++++
 5 files changed, 368 insertions(+), 104 deletions(-)

-- 
2.51.0

