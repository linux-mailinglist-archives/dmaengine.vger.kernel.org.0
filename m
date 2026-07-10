Return-Path: <dmaengine+bounces-12293-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /1aLEp+tUGpR3QIAu9opvQ
	(envelope-from <dmaengine+bounces-12293-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:30:23 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 339937387CE
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:30:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b="QV9/Tk7R";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12293-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-12293-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 90935300E15D
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 08:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBE13E51FC;
	Fri, 10 Jul 2026 08:22:08 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020086.outbound.protection.outlook.com [52.101.228.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23E1352C4F;
	Fri, 10 Jul 2026 08:22:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671728; cv=fail; b=tHdUb6+12yLxQyzLD1CWkMQxhtDTPEhqZNoqDzHAowzttx9YzdlZkBh7zap/jOjoga+U8co0eqiWqUBw2D1WWyCEmFUpn6XTRjfwN+LwmipR4l8bqJuOr5CVPCZEFZwjipY0OmkXI5kSFeQZYP+A5iqSfLF4oZh8OJCVNsvotVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671728; c=relaxed/simple;
	bh=WGPRXMELHTt9hjgCkVY0oT2A/tXHbs8v2tebAHXW4/I=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=q2pB9RkfX0BJN6wMb4QweB8xc4g6kpP8lijCvrkv5HlfR41qtfVHzd4MIis+qjXs0Xy/5mQijIBuHAcclpel472RmVAkYfXkpCPHndz6hP+IhdtfNl43ogfwQWTZhrOHalIWK1mUtW+/LI/GVu5DvYUdk8CIPdK4Ce5RQCQdZPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=QV9/Tk7R; arc=fail smtp.client-ip=52.101.228.86
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/txFiTl+CMDS0xkDKTrTgo+FkotLI8JRcCsDtd8Ks8r1LLU3PX1fOD2YLGCYLo7dNH6CqsT8oxTe4up7Qc5/+/fk3eG69Ktmin1+Qa9PA+KrFLMul+YF4Cch7YCSIJvxuuA0cVLIhFuUCYknex0Y766OALHq4dHro2sHUVDKYpZA2hhYc9oXndHitaDC22GCfyzqBUR9eNDyJ3af521Ki15hsE4v7nCcwn+FIiL6jMOYtRM1XUbbGWlH9JVFynfKpUR3kzKbk/NjCObbOrcByYgADUQ2j5X8pyRGpO+AMZHl6PfGrOfWlFW/YxiRwyH0AZm2RjBisGppE3S04DF3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUxcX88APeYYTFGSq8/ttgDQu4tR4G04rhWDroR+izs=;
 b=VxG6EdUnFBMHLZ8yEKMFGBMeQI0iJ4Q+GU2VR/QEMVujFRdUmSSYVe4LBhWbWAke2pFy9m1yKo57+qoBVvYXjj1OatrRk4YGL01aHl0KaFPAJkgw6bVd3NomPIPGewT8hco1nMoQ2Sl5RGR49kR3v/lhagczCvtK3LUUhhjIrcuNeo9Ukjp3bgZ26SFQKXktmv885qkBtpkKFo/EqK/ZUPlCvW0/dXi8O1hq4j+/uhrb45Dpiav3FDCfkeTLrY69ZGOiwEnSUUF+3dXMEq4aNjRTivlrumZsgtr+vZJ+C9grW/P7BX1XiU+CroBlRu0ZJ3qX28sB/33k1MlXVlhemw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUxcX88APeYYTFGSq8/ttgDQu4tR4G04rhWDroR+izs=;
 b=QV9/Tk7RZFLzHtucS2AohaamZjkf5p7xy6uMmFI5hO3meb0Z8rgWUVSBCTos+JwaOqav4cRhnzHt3cUUen1hFFLGa7bBgXAotcdhckrn9PlC0xlCkiXTsFhxk65ZQUT0iymXyGevye84MCCYPDeuevzK0dqpFR+Ac7Vj8tR8R3s=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS3P286MB2742.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 08:22:00 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0181.009; Fri, 10 Jul 2026
 08:22:00 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v4 0/6] PCI: endpoint: Expose endpoint DMA resources (part 2/3)
Date: Fri, 10 Jul 2026 17:21:50 +0900
Message-ID: <20260710082156.2395844-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0076.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS3P286MB2742:EE_
X-MS-Office365-Filtering-Correlation-Id: ea62d794-f90a-4232-f20d-08dede5c50c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|23010399003|366016|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	O9vCtuCiKYS9Qn2T0FQrU8P8xn2Bcho8vnYEPEW+bTs8TfTVmkWbqbclQWP6GJuOrjBYOK5ndQjAdQrDQ7kQcQibuht8HT0GdhCQ2cz0p25h5st310Z2YKXx3dm2Fqze4yahoAKdsAGTQzwW4a/8e/XTqr1szFZoSPGr9zCsU9rxwXy2w8VY+efHoYLgmyStwMPJerJ9ls170qC5Zl2YLokn+pIJf+jiCClYenvtLYAablWulmd4LzDtirXpKD1istlZKGp24mQhwf28MAs6zr2A3AVsjplZoSbzV7KH3i3nRVlcl+CfvnDMZ/i232RH4I6qnKS5vEverG3u8ZvA00/xn9vv/7RXCYUjnn2fWQVYVeM8LgayDmvylufCiQiX56IUAxhdYjjOHczi1sLm2xto/6oHeY8xEuEzfoLLT0aBU3gFB0zcX/WcszhuUXQYjpC77cosC0sqjnMCsfI0FntLAYpF4tIZ0fSpU4FXaAmDj0Z//vhdCDGQv+t4VaDtY1DI6ZxK8Hp4+TjEbUXCCGPjTUcCsJfIff4TAdMP0pWuiWAL1T0T9WUOZzEMGnmfTBUX7ngzeTt+vKH0s+idqbvaZuloSuMPk+yzyeTIKVWuPCmzt0V2Kvxc3W3FMKEd37fT2+Gs+jO39MnvOsm6jrDFrx44ggYI3QuKKB7+q5k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(23010399003)(366016)(56012099006)(6133799003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eTrk+uwFlYpICYjXdygeVn97XO4DEHTcUuVmO2IqwPq1npEgNQDmhCiIe0T4?=
 =?us-ascii?Q?4J9WpFHFOVoWzYIDjKpoaMvHexm1kFd/xtwQPVCa/qxCJnrdvsmglnGRvrWH?=
 =?us-ascii?Q?aVNMxx2qEFMoDTL9SmNp9fEumPXkdWN/NmG1DdxyFgrB97doptNmjxb8ywwD?=
 =?us-ascii?Q?2L/AvKTZRSJHp+7WcF4jWK0klWiRsTSQplgID+Ig+/mFZIEhrbmcYNHnZxeB?=
 =?us-ascii?Q?17LZXKoa62MtO1Dnz0BHRSR6d8qe6ylu4zTqrhE14Re0I7vZH/kf+FAouxzV?=
 =?us-ascii?Q?J1POAN5JdpliPqI8xIIjt2q3fVrOrIx+suFR+sne/DWA+GftbfLGaR7DeTvQ?=
 =?us-ascii?Q?hMnjeAJTNfsO81haweHE4iErVuGHqe2hU2wku2acsSSIhsiIda8D1tXtOYAI?=
 =?us-ascii?Q?7H21ab9rCMJ8nZe+NQMes3AYqVfzdJztNDVGC/Z8aHaSOo5fuUB3wmpwE0w1?=
 =?us-ascii?Q?mGcIwtCrQO0O+cYLDbw73AcO5nh04o1yKzXdCCsP3t7ZawtpCFHZAqwZvsS2?=
 =?us-ascii?Q?1BnzmbDOH3Un5kNvAL7y5ZidenhNvVjZag7Rom9oW/HvdAsd8nj2h+JBhBlV?=
 =?us-ascii?Q?DtfdZDgOeX8Fie14zKYDPVgwTlqV0ZAZlIfIhvVCTF3OY02MRMeGA7KLl/BF?=
 =?us-ascii?Q?CfV0yB/WDda4r0UgtQqt1t1R17yV0DVRwattHMoMUEnBviTTN2QE5uB8OQF9?=
 =?us-ascii?Q?EEhBatk6HioKLC9Z3kWZS56mRxtQxcBHQ3rkimSYIN4XjpWBgCrmI/uLyn8J?=
 =?us-ascii?Q?OTpdEk8bWdeyLASHoW0byfLcRa0nkEjUY4nY/WQ0UVB59/Wfx2jDyiPc26Lm?=
 =?us-ascii?Q?FJ0ojI6vH79fG1o2md8UsLCWzzI5tfYIeI8rtN6KRSumvggHgU8myIzX80q1?=
 =?us-ascii?Q?h68RPJhvLCYRlBamWvPm4URsZuvWLKeCaOFGgUniGUkcilA+4mu5usuwOA7Z?=
 =?us-ascii?Q?pZ4rv7vDdDr4vMU+axb2eBbzcPhB1/S4aB17Fts1PI+Y+Ci+liaen5j4WIUm?=
 =?us-ascii?Q?XM3cZSIW3HeSR+LDHNQSi48zGX4SVHwIKfBBgaRovMyzeBlK1vuow2300eWs?=
 =?us-ascii?Q?uGx08WshWJdwRHyKDX79UA2F1aica5hvZlQnnTn4ki6f5y8b2yDC+7mWko3R?=
 =?us-ascii?Q?bBJQ6jjaX/NWRkmn2okhxGp3h2G7GoniImL+YgsC1W/vSA5JhLD+cQ3y225Y?=
 =?us-ascii?Q?Yx3jsKLTqZg76RUJRrI3/XtLBNhAECYgWPS+FGF7HIwMwp8K4iftwgP+SuLb?=
 =?us-ascii?Q?TdqHE3zrHNiFUpzrzgF3wwQZi85k83uZU33uB7PTstAD9A5uXqm/uU7xraRI?=
 =?us-ascii?Q?r+C8OSDnHGzdxUV+TTQ+i6uc6+gvP5s+fVp9msGfn5eS23j2PegQHuImcptP?=
 =?us-ascii?Q?VbtozRxHxwZhYikhealV+LeMWWwt5K7W87sfv19okz+qavjcrERJmn5sDOSu?=
 =?us-ascii?Q?Cf8qR0mvb5dy0S5AfJ5eyn4ehaWchm1tl0DkrJWpG1TuJZRPRreXj8yttxYP?=
 =?us-ascii?Q?HFp2WK4oF7KXFSbn1aFZ5J62df8wzi1DjZ0LH1djp2U7YXkb5Qa2eci3535c?=
 =?us-ascii?Q?U1cOobjo8LX3FomgAqrDhSfmp0PmakieFpNQWhinrTtsT2PLEXIAzh11GBMC?=
 =?us-ascii?Q?t+6xyfFy8XCO3lZ8KeMGzUGJohpzhXjnpO/PFmxt2q7IwII4AEdi0APt94LR?=
 =?us-ascii?Q?KGwZ29UfLn0a+eskAbUcK0nJHIVmgFWTsnVPfZe1A6Q2aX/5lS5gebK+gSbz?=
 =?us-ascii?Q?g0Z4VZ3bn1BiNpRPCVLph0SmUlfj7ITJgud3wT76gu7AX4Oi/It9?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ea62d794-f90a-4232-f20d-08dede5c50c7
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:22:00.7664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dssro6VdWJzzXxFMDsecDXAuyMLYTHcR7EhDQkqyXvFeGG9Od9dcUIPh/SZK47X6QGpDq6ctC9jIdG7b9pNHLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2742
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12293-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:jingoohan1@gmail.com,m:lpieralisi@kernel.org,m:kwilczynski@kernel.org,m:robh@kernel.org,m:bhelgaas@google.com,m:kishon@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:linux-pci@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,valinux.co.jp:from_mime,valinux.co.jp:dkim,valinux.co.jp:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 339937387CE

Hi,

This is v4, part 2 of three series for PCI endpoint DMA.

The three series are:

  * part 1: dmaengine: dw-edma: Prepare for PCI EP DMA
  * part 2: PCI: endpoint: Expose endpoint DMA resources
  * part 3: PCI: endpoint: Add PCI DMA endpoint function

This series adds the PCI endpoint-side pieces used by the endpoint DMA
function. It defines the BAR metadata format, extends EPC auxiliary
resources with DMA-specific resource descriptions, adds EPC operations to
delegate and reclaim DMA channels, and teaches the DesignWare endpoint
controller to publish and delegate its integrated DMA resources.

The metadata lives in a normal endpoint BAR, not in PCI config space. This
keeps discovery independent from controller-specific writable extended
capability storage.

Dependencies
============

This series depends on part 1:

  [PATCH v4 00/14] dmaengine: dw-edma: Prepare for PCI EP DMA (part 1/3)
  https://lore.kernel.org/dmaengine/20260710081518.2394357-1-den@valinux.co.jp/

---
Changelog
=========

Changes in v4:
  - Rebased onto the new part 1 series.
  - "dmaengine: dw-edma: Add delegated channel request helpers" moved
    from part 1 into this series, next to its only users; this also
    resolves the undeclared-functions issue reported against v3 5/5.
    (Sashiko)
  - Lift the v3 PF0-only restriction on DMA resource exposure and
    channel delegation: part 1 now programs the per-channel requester
    function number. Delegation to PF1+ therefore requires part 1
    applied on the host side.
  - Move pci_epc_function_is_valid() up to avoid a potential error
    pointer dereference. (Sashiko)

Changes in v3:
  - Decouple logical DMA channel metadata from descriptor memory resources.
    Logical channels now refer to descriptor memory by resource ID instead
    of embedding descriptor metadata in each channel resource. (Sashiko)
  - Replace the v2 DMAengine filter-callback metadata with EPC-level DMA
    channel delegation/reclaim operations, keeping DMAengine provider
    details
    out of generic EPC resource metadata.
  - Add the DesignWare EPC backend for DMA channel delegation.
  - Limit DesignWare endpoint DMA resource exposure to linked-list channels
    until non-LL metadata and host-side parsing are added.
  - Suppress DesignWare DMA auxiliary resources when the local DW eDMA
    provider is not available.
  - Reject VF DMA resource and delegation requests because the DWC
    eDMA/HDMA register window exposed to the Root Complex is PF-only.

Changes in v2:
  - Follow the part 1/3 v2 channel-claim model: EPC DMA resources now
    carry DMAengine filter information instead of raw DMA channel
    pointers. (Sashiko)
  - Update the DesignWare endpoint resource provider accordingly. (Sashiko)

v3: https://lore.kernel.org/linux-pci/20260620170438.3756593-1-den@valinux.co.jp/
v2: https://lore.kernel.org/linux-pci/20260525063129.3316894-1-den@valinux.co.jp/
v1: https://lore.kernel.org/linux-pci/20260521063405.2842644-1-den@valinux.co.jp/

Best regards,
Koichiro


Koichiro Den (6):
  PCI: endpoint: Define endpoint DMA BAR metadata format
  PCI: endpoint: Add DMA auxiliary resource metadata
  PCI: endpoint: Add API to delegate EPC DMA channels to the host
  PCI: dwc: Expose endpoint DMA resources
  dmaengine: dw-edma: Add delegated channel request helpers
  PCI: dwc: Implement endpoint DMA channel delegation

 MAINTAINERS                                   |   1 +
 drivers/dma/dw-edma/dw-edma-core.c            |  86 ++++++++
 .../pci/controller/dwc/pcie-designware-ep.c   | 186 +++++++++++++++++-
 drivers/pci/endpoint/pci-epc-core.c           | 102 ++++++++++
 include/linux/dma/edma.h                      |  14 ++
 include/linux/pci-ep-dma.h                    | 170 ++++++++++++++++
 include/linux/pci-epc.h                       |  61 ++++++
 7 files changed, 616 insertions(+), 4 deletions(-)
 create mode 100644 include/linux/pci-ep-dma.h

-- 
2.51.0


