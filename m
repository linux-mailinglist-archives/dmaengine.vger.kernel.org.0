Return-Path: <dmaengine+bounces-12278-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oka9MG+rUGq43AIAu9opvQ
	(envelope-from <dmaengine+bounces-12278-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:21:03 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 178E5738613
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:21:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=fIy0T+c4;
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12278-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12278-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E59443046D47
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 08:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C276B3EF0AA;
	Fri, 10 Jul 2026 08:15:27 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020113.outbound.protection.outlook.com [52.101.229.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5873EEAFE;
	Fri, 10 Jul 2026 08:15:25 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671327; cv=fail; b=rA7XxrSYODmDbPJ0bds2dsXDZ/cSFrZ78nq4NRgeAVcAmtVx/4KTHZYFsUT3AxqPzSVw7I/vsrx3rHaumZQy9CLbI1sNpP5px5vsEX/Xqqng/MYVhWrGaSDVZHPzD3L7m1DpxmTBqqQSPI35Nxp+m9A7ZN0RnF7D3Yy+8CqD2XM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671327; c=relaxed/simple;
	bh=RbfAU2tEdo0ZG2SNRjNkvmw5cfwsd3MZiNSHfw5fiSM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=T0HOHjDEoPDEeH9YjJNPqHBIrqMZ8TDYdcRY2RhARLELZOXL7URPL5iEOtHCOcEn3wWdWMIjpJdSfHmMpmx/+C57bUV5ytNgIvfHuJm6vQ0WFuLuW/rUMOeWPQY/8iBKAk8+yBxLb7HoWw7YdChK8dsR5Hr0jTdM+teXkbxZWM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=fIy0T+c4; arc=fail smtp.client-ip=52.101.229.113
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QvaOxAsJR16ZyS4CsphyZIDl34mJbXcx/EtI5O75Vmn9Bd00rXIBJX3DwZTCsrczn9aPhACHNtn2k53lNfHCb1/BxueX91fxYtHv02CE/aGGD3rcIe+wt2UopHIu+2Ajq/G2rey3L2j0PsMq29ufM3RsJDokHRtWT+11hnd1Wj+M5Mdp4jZ7HD9vDFnBlzPco+zdcVAvOiuI15zXd5kBECvzdDIowNiEELHbWVUC/ENZSaBaHFRysOlFb6bhCahcTJuD2eGJEz+E4geaqYgkitIuPyKZXVx5/y4aJL8g7aaHbZRc6AYIGrAj/QqZkm5GX+P7l+QI//HN6wvi5USg0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2a8wIr1hQ6f8z7+O1jcHsKBfMt/yP7CZCkABqT/Xsyk=;
 b=J2q4+HUP/NvOYR3iutYNY8DRlRhsXAuzGiypZ3x6GP7YhXBqq7sLvQotYlUwZn2kN8wWUXrVrlTifFi/S2Ubn/doPJXVewm2SIIJq0RApZESl6PoFsgicb1cB7+xTs/kc0cwp9CGVy+baZ7CjhzGy8fYPLFMveRsso1dgRoCn/m13/Or+aSKWVtsVqCIFsYLwP/h47aSvaRM3JDd8lwpmUMyL1RuWhm/i5150CoVgFKbBKSplHV7zjWrFNhA/dUWZQ+pP68+HVlgHyvma3Etal671/0WatEIOIhcSxi7CD6L/A5WLDVQPkRFvDufCkLMEDlfIphhcdXATjw7qGjtwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2a8wIr1hQ6f8z7+O1jcHsKBfMt/yP7CZCkABqT/Xsyk=;
 b=fIy0T+c4e/wMFkOErgOocp6LslIrQSL+33bgQNgauIQMx536+Z/PyKYSQQDIXkIOFvLbPgoeDW47mQGce/4pejHYoVnt2KppBCyp5fsdUFyiHhBiAHSEG1M/8kk26kovvKPsjXuR1sokDeBH7xBXpLll5jc3yeZr+Yut0SRUDV8=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB6307.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:409::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 08:15:20 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0181.009; Fri, 10 Jul 2026
 08:15:20 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/14] dmaengine: dw-edma: Prepare for PCI EP DMA (part 1/3)
Date: Fri, 10 Jul 2026 17:15:04 +0900
Message-ID: <20260710081518.2394357-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0015.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: e8bf8e53-41f4-4716-f9c9-08dede5b625b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|23010399003|376014|6133799003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	/tf1abHGkNGnJBK1LhKlAOoMuC9jAvoL2uYm52UfZEB++fxs+SqwuiJOks1RyLncXqqIQwhsIgL3B/5+hFOrHA5X7m+RpiDgl/+zP5NjJZPFhw96A9rI+lW+aL7RP5oCYoGYPfsbZrIfaqGQA4Kn4AYLNVE332R0x1J1fcAOSbO36tfBOQHFNmPQP/RckMhV16wEUaifZJk7rA17sJYJFQmwOuzn/FPago5HqyMRmbb7lAuK1a9AIGNoZYbd/deJxAT4YUlOhL6TjSrXDXutjOthHTdEXJzawq+6bp1D6Vfihb2G335LV2Is5FFDh6yoNE1B/z7o9tktzIG8tLF7GFQdjbgVEBv6OOtD3cXSeMhOJkrwp9Aga0TyRWKrZRxZFQwiYRpyUjBkRTuVl/8GB2u1jRxdSugLBCXGGAY4QnnO882sdW9+dZm6UGcXj6kvCqmcQ0C6wtTsxvrBAp7yALHwoLJTfS0D2jZqlZllEhcRyBK2TY/PyR4YQwh/l1n1jpYZrZp0kDzhGyowTGHkE2dVWxXSf165j+V6/HIajGxBtEFgPogSM+yDXN6r1SPX0DWE2P8UFDhao5wIu1VJXvTN19UD+GbYFTj6M+a7pcO76ESICGXOHpNpXIGzvBBCGPj4+r/MD0U6FZs0ZXffMjPF4+KDpcxwbCUMKa+VzeI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(23010399003)(376014)(6133799003)(18002099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qEx7BRYCFYb7T627IBllJ79Tj/4asWViru+970BaI0PeGX7uKCvwiVWtF3H/?=
 =?us-ascii?Q?2kdR2ZV1DzXlkNPnNE+N553Qaq+vA71WA5GBswgqTS7lRNLz2gw6FCkT+r7l?=
 =?us-ascii?Q?Kd2QXIvdT16ah7tXC4nE/EhNqEtebh5sPGxioqVq4J4W/8+P2N4Hgcvren/L?=
 =?us-ascii?Q?AnFPMSK0fyUUYClIqwYG2+rqIA2jdpfWTx394Oh7EsOL5WbWhqyhXKTicNft?=
 =?us-ascii?Q?yJPcN3fdPZpXx3vVWDGp8TFhzRpvZVs79kYxmcR0u1JQf2/oOD4kv0i7rgcL?=
 =?us-ascii?Q?3S+hfMev47nvBGzxz7vAkfoIqqPdGyHoXQj2dYRJ4/LzeA8+oohj9CYq4P3c?=
 =?us-ascii?Q?U2+0Hj+jAKey34+z0Ri53JFD6enwRvqeR/sywOr0yNDw2jHFuAQ3nVr1g7gE?=
 =?us-ascii?Q?NBsMlCgKsVEjMA4zPntXmOVXY8ZA1dahL1+KtcSAuLZvK8B6hBvNEeN5pThc?=
 =?us-ascii?Q?ONzrKV3cuSTZkloQ+DJLBuh/niaCv0Pst8FrYFnAk1tbKntypfL7W/gbeXhE?=
 =?us-ascii?Q?pjiDj/m6sz6dD2fDHIW6cATr1q0P+kemJkeZB1yaE4MOghnkJsRfxb1DT5FS?=
 =?us-ascii?Q?EcpfHFph/r4tRcqNHtoKSW4vA/k/PTfkQelad8VwitdawFf5hAB8Ni+0EoV+?=
 =?us-ascii?Q?iv6v3KTLhtx06mW+jgA3nLyrESSRRWuIEj79lPy0NeGHFHiQTGUbio9EVdau?=
 =?us-ascii?Q?5ZIwOPe+3N6wYNlaknYBFMMgWHY2ZBzJvfQKAA0LzOg6BRTpAalXTL5kN/g8?=
 =?us-ascii?Q?KZPM1v0u96GllW2kUJ5/djFjKOIKbWtjCnnH/7A/HYvqaTh2VVbfRnvsh9Lc?=
 =?us-ascii?Q?vGGZb0f4ip/zfAINeplYjD9uRvD6f/9aUq1dlpWeZbCbOq/RPu6/XIikUm2/?=
 =?us-ascii?Q?iZBlbQh3K5CAZO+DvWp9/ioSh22WdkEciUPVxWuMwuWLbvrJoMtC1Rv8R/xa?=
 =?us-ascii?Q?4bZn5LcUgnPTgVVsfxeL70LACXKUmpOuF21ipjS5CtsS97yR64gKP46h1q/O?=
 =?us-ascii?Q?R/ZSAKtnAP+1J2P5Y0P36DFb8FdyIt4nVBoMB/oiwtIHr4mg76du45Wkgo3M?=
 =?us-ascii?Q?VRsoC8K8EcnBRf0rs5mzUxx8u/BHvXnWUhZSnwxwf3jdi8+rToRfRDjqG46X?=
 =?us-ascii?Q?c/XLvgpGG44iQcr3aypPOXdS6n6nmaUr5LfkP9B8TxnTAendd3zIxKONx0G0?=
 =?us-ascii?Q?WUpeHMCdBIPLmMdVSssgUTuq/lKb9VJPxTD98kHpFQe5jiOR7SjUZIlbPThK?=
 =?us-ascii?Q?p/qF8YSDs8BjgEwimqCsCCMpw0RjPwC4D1S51VPGzosa/7vieoftHB4aUag3?=
 =?us-ascii?Q?h80u3G3+982TZNARChqnstzspTQUFUl1V8XLjzUW2qb7V7KR7ZK6IltStaz2?=
 =?us-ascii?Q?xPCp7wdL/O6+ZvsGfPOkAuAB6CCSREL2uFlohKQioi/FmgwJMe4ABNCisKYx?=
 =?us-ascii?Q?8OSRCwQ0Vu1ZJTRcX8qs5kwjXCRlKh5vsqiTQJFx37ZWFDYPQ+VlXfiPqpMo?=
 =?us-ascii?Q?rNhDNVvJKsvdZUCrKCSwxo/GgfDRJMv439sK6j4LQ22IvABSiWtjP4DV2ApW?=
 =?us-ascii?Q?TH1rngwGYvLyOV5nQEAr43bqiNuedRVJv2sYY8zb8JIIp3kG2/FhaQMXO6mR?=
 =?us-ascii?Q?B0di3n/CwERU9J2v3s3GT86xglp2n+jzZ6ISwHs5rcaKz3V6qrqcktdrBIKt?=
 =?us-ascii?Q?4qbIhcrq07CnUr7M7wy7VWpJw3ydyUCQMctKUEOiaXsfQDVByH5u+efMfVev?=
 =?us-ascii?Q?1n3qyFIxNXhlCo0WsS97Rc/GFVhYEu+nJm1b+67EFIEgJQLXpX5P?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e8bf8e53-41f4-4716-f9c9-08dede5b625b
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:15:20.7507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: POn5oGZ9mqQWCcxhsspOFBJH3pC8PIyU8mE0PL8ieke9esWTEaVRXiF/LIPXBtP+rXrBi4/ZL1BJ+iZ1LTh0Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6307
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12278-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:mani@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,valinux.co.jp:from_mime,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 178E5738613

Hi,

This is v4, part 1 of three series for PCI endpoint DMA.

The three series are:

  * part 1: dmaengine: dw-edma: Prepare for PCI EP DMA
  * part 2: PCI: endpoint: Expose endpoint DMA resources
  * part 3: PCI: endpoint: Add PCI DMA endpoint function

Most v4 changes come from Frank's review of v3 and from the rebase
onto v7.2-rc1 plus the dw-edma groundwork series (v3 was based on
Frank's edma_ll, which this revision no longer depends on); the
delegated channel request helpers moved to part 2, next to their only
users, and a new patch programs the endpoint function number into
each channel.

This series is (re-)based on v7.2-rc1 + my dw-edma groundwork:

  [PATCH 0/7] dmaengine: dw-edma: Fixes and interrupt-path groundwork
  https://lore.kernel.org/dmaengine/20260710080903.2392888-1-den@valinux.co.jp/

and parts 2 and 3 depend on this series. It is independent of Frank's
edma_ll work; the combination of both (edma_ll v5 applied on top) has
been tested on an R-Car S4 endpoint/host pair.

Scope
=====

This series prepares dw-edma and dw-edma-pcie for endpoint-local DMA
channels that are delegated to a PCI host. It does not add the endpoint
metadata format, DesignWare endpoint resource exposure, or the endpoint
function driver; those are added by parts 2 and 3.

This part is the DesignWare dmaengine backend work. The endpoint resource
and endpoint function pieces in parts 2 and 3 keep the generic PCI endpoint
interfaces separate from the DesignWare implementation.

In summary, this series:

  * adds per-channel interrupt routing so a channel can report completion
    either to the local endpoint side or to the remote host side,
  * adds quiesce operations for the resources represented by a dw-edma
    instance,
  * programs the endpoint function number into each channel so DMA
    requests are attributed to the function that owns them,
  * adds partial channel ownership mode for dw-edma instances that share a
    controller with another OS instance, and
  * prepares dw-edma-pcie to describe device-specific DMA layouts through
    match data.

---
Changelog
=========

Changes in v4:
  - Rebase onto v7.2-rc1 plus the dw-edma fixes/groundwork series:
    20260710080903.2392888-1-den@valinux.co.jp.
  - Split the HDMA interrupt setup helper out as a new first patch.
    (Frank)
  - Rework the routing patch per review: default-irq-mode naming and
    call sites simplified, chip->irq_mode dropped. (Frank)
  - Revise the partial-ownership patch: message fixed, validation moved
    into dw_edma_check_partial(). (Frank)
  - Move "dmaengine: dw-edma: Add delegated channel request helpers"
    into part 2, next to its only users.
  - New patch "dmaengine: dw-edma: Program endpoint function numbers",
    so channels delegated to PF1+ issue TLPs attributed to their
    function; this also lifts part 2's v3 PF0-only restriction.

Changes in v3:
  - Replace the public dw-edma hardware-channel filter API with delegated
    channel request/release helpers, keeping the DMAengine filter private
    to dw-edma. (Frank)
  - Rework IRQ routing so local routing is the zero value, existing
    dw-edma-pcie instances stay remote-routed, and delegated endpoint-local
    channels are handed to the remote side explicitly. (Frank/Sashiko)
  - Add HDMA native interrupt routing and allow channel-granular partial
    ownership for HDMA native.
  - Add quiesce operations and use them for delegated-channel reclaim and
    partial-owned remove paths.
  - Reintroduce the IRQ data initialization fix because partial-owned probe
    skips the core_off() reset that previously made the early-IRQ window
    unlikely.
  - Adjust dw-edma-pcie match-data preparation for the CPM6 entry present
    in the new base, and reject dynamic PCI IDs without match data.

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

v3: https://lore.kernel.org/dmaengine/20260620170040.3756043-1-den@valinux.co.jp/
v2: https://lore.kernel.org/dmaengine/20260525062420.3315904-1-den@valinux.co.jp/
v1: https://lore.kernel.org/dmaengine/20260521063115.2842238-1-den@valinux.co.jp/

Best regards,
Koichiro


Koichiro Den (14):
  dmaengine: dw-edma: Factor out HDMA interrupt setup helper
  dmaengine: dw-edma: Add per-channel interrupt routing control
  dmaengine: dw-edma: Add core quiesce operations
  dmaengine: dw-edma: Initialize IRQ data before requesting IRQs
  dmaengine: dw-edma: Add partial channel ownership mode
  dmaengine: dw-edma-pcie: Track non-LL mode in DMA data
  dmaengine: dw-edma-pcie: Add capability match data
  dmaengine: dw-edma-pcie: Rename vsec_data to dma_data
  dmaengine: dw-edma-pcie: Add platform ops to match data
  dmaengine: dw-edma-pcie: Add register offset match flag
  dmaengine: dw-edma-pcie: Factor out descriptor block address lookup
  dmaengine: dw-edma-pcie: Handle optional data blocks
  dmaengine: dw-edma-pcie: Add chip flags to match data
  dmaengine: dw-edma: Program endpoint function numbers

 drivers/dma/dw-edma/dw-edma-core.c    |  89 +++++++--
 drivers/dma/dw-edma/dw-edma-core.h    |  28 +++
 drivers/dma/dw-edma/dw-edma-pcie.c    | 253 +++++++++++++++++---------
 drivers/dma/dw-edma/dw-edma-v0-core.c |  72 +++++++-
 drivers/dma/dw-edma/dw-hdma-v0-core.c |  75 ++++++--
 drivers/dma/dw-edma/dw-hdma-v0-regs.h |   1 +
 include/linux/dma/edma.h              |  42 +++++
 7 files changed, 445 insertions(+), 115 deletions(-)

-- 
2.51.0


