Return-Path: <dmaengine+bounces-10609-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKS5FiOpDmr6AwYAu9opvQ
	(envelope-from <dmaengine+bounces-10609-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 08:41:39 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA55659F8FC
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 08:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 895D43021E6E
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 06:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9AF313293;
	Thu, 21 May 2026 06:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="UWCEZLxK"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021086.outbound.protection.outlook.com [52.101.125.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF7F360ED5;
	Thu, 21 May 2026 06:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779345409; cv=fail; b=pZq915yb3Jyg+VdlzKGuIqMPXK4S63+JLyT7Kp3IC3Ypua6vv5y9z0BamFCrqR8XVZe2QwEV9Co27fYDvJpRosy9L9VbobpyYIj8VruvC3FdqI0dNwMFTD5Da/KrfmvguKFwwr38EhfL52Bki/VcYojLKhbTmAa8syTknINHVQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779345409; c=relaxed/simple;
	bh=PGRC0MS/90EF9tx5BdsrGwbt92pvQDRvWOkcTh9Lz90=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Asfy1LcfEV7J2xt/HlyOmkVJgHZmXXN55vGyuP30K46kRm5iGELDNl963SBgL1Ypj3ITjhR2zABO+rwQubZ5nQg/UeaMvOq9eUhrhxZZTdNuzgAkS/TMTIcXmvPu/ff7iq1PxJVKEnwEx6VB86mj4sZwDZnf2OvqnIWtUn/F1fI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=UWCEZLxK; arc=fail smtp.client-ip=52.101.125.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CSVgqQTfBx0gT67DUz6p13+lBU6Sw2aifwFaPtfMx3yvt7OfEr78aUCDBTz4f06u3WPrT5N/Ajg+KQIJm/r64f1SakCQgOYPLRDIEJmaNJIlmfG+6NhNxuWWusuXDmEMRQUMiqG291ZEeBzp+elGM3jU7yJc2VqkaV+ejZRQj+ckhzkPZX+cRx+og4tTjeI7y+mPYljxZ7L4D6vGo8zbdobbgNVE1Kd2BLHi9SqHnHR7LKyFcX82uOgAAp2MtrpQD9MzCF3/Gh40Xm2wjAO9Fa8a2J2u1GU0xcC8BNWMas+FeNIQsSJdNQEs2GMwWbybLsZfRshTqp2RqTEctS1pbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCD1CneeNG4bx3c8MnN+G+g0qCgniUQd7dkavz8OWDw=;
 b=LuJk6pLjGCFyxPSmNqXwR6eAoXPtnPC3fpU2OPm4MEU3FYPTuXHF6raWoOv8agMwBehf3msvdswVnWn+t08XkcYtI0ElpbaFM1mS7ZNltd1AXTs06ZTNJBFSOQb+yPDjTjM0kl2TJ5t8Hxz3SBlUTrtZb/8l4988DtDY7dFXukvy2pcwSk8rBtSeo5GAwMfp6Ix9LRh6Za1f7UayTCTtIiNY4OCE297eFODCnZVXzRVZFzPFlsX6yk4QWHAA8OT8NCu1aXOed0ooX8BAp8NRcLEAHc8QaqIbblR4oc6hgSi7YbUSe1oXwqaaojrBElJq6RRGSFb4ZXXIRrcbDyQySw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCD1CneeNG4bx3c8MnN+G+g0qCgniUQd7dkavz8OWDw=;
 b=UWCEZLxKs8yiFA/Dz6vh5F6jlrW7h/07ijQTi+qtN3FxIqJBhNrbqAoo8e7/TDdzhkpR4PfXv+kxRwnffkTbxbWHsBlZOyZxoQBfqDYkieBqeUm+wz05iaPo0INSTOcTh0WSOkoeTUdV7r12FMP9ewhrIyQwnW619mH3jaKE/Io=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY6P286MB7399.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:35c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Thu, 21 May
 2026 06:36:43 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 06:36:43 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH 0/3] PCI: endpoint: Add PCI DMA endpoint function (part 3/3)
Date: Thu, 21 May 2026 15:36:35 +0900
Message-ID: <20260521063638.2843021-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0018.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY6P286MB7399:EE_
X-MS-Office365-Filtering-Correlation-Id: e4bc8745-2766-457c-8362-08deb70352d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|7416014|366016|921020|18002099003|56012099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	qDi38CY3dXCaq5Lxkzm8Z0dHFHH0aYAHfOJDYa+QG4Z2+o1bcwXEiNiAZMtjBsI8RFsoiipU7mQZZ5MhKvp5XzfyCakpwtmfo1zXVM4EitaWC9Mb8V21x2gair2q+2R3ZUpGYLr+4doTQVAWFVwGH8KTDgdHMLqVzo8n893/JK9f9vBmeV/1oaaGuDGixP6Wj2ghBPiU0+QQ1bjpKahAPFXEsMNWEH/sIOi00lWppaGFqvAcJQ+lLa6rxdgqZjDq8Jzh5VKPFLotThfMUOBv5a02985i4IpfLJwkKxQpAZgl4LPw7MopN5pd6oKwJ1RGoWl1dxkzmwIo/c+WZQH75nMV3PkCWnNB6Gafr41jAWL4PzvuwR+R3rULWQ1sNdFCiil52hEmVEp9w7ncOlaIfHhFtAhwXLEqpenvq6ARhGywQSNEKyNCeiSc5IxWYpNVoKhlKoDmLQpbsZLNeSb2V3lAEHxDDoPb7USML60OhjlbgonEU22x4SOj56gKZczUq/KP6TTL3LIAGrmc/Y0EYHpiFeoQGsvTIYT4z9IpLZoppF2tfBvswn3zbr4pAXmD5MwSNExxZ6OONtw2iJslkOKRzXNT72rsjXPPi3jlOzHlvD7hwcjnsOFVzmPGcXFRhtfxEgJEzVjGWHO/fAZcVJKHQchsFZwfx8C8EPT+swA1PhlKxuHlx/UVPycvGJX+9oU28/MMItQsoEnatlcNkVbuwDMpWvXACSG+q/qVaGxUHBZQfp67oUhuIrIEcbjI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(7416014)(366016)(921020)(18002099003)(56012099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZzuJBd6ADJ+HgYnP6TXW+AJAHWe020LqTja3I5QPsOpg1C8I0Nmb9xHiiipG?=
 =?us-ascii?Q?gjhivIa9vg1B0/yU7aTeZTbBS2O8eT3YJwrWl3gjuN9EGTO1fYaa2wsVEqQq?=
 =?us-ascii?Q?cpUEk2m0sGdxWW6H6mPo5LT17BEAk3uxc6plR2Tke0h4YlAHZi1krGU8hRD3?=
 =?us-ascii?Q?Pux1/StWw3gF/Du+ZeSbicfMZytQ8bIToTeRqud6FEAn8N2xeX3L1+0DAo6T?=
 =?us-ascii?Q?y4l805BiVmUMCZtauV2yjFWqBeHmZ7gNpo9nZATY83M0fwK1MaGn6o6j82oA?=
 =?us-ascii?Q?cG5cl/7+GuCCTQSxBIZFMm5yswXMlUlHheLBrgl3ACD/5ztAj8mby+jtjKc5?=
 =?us-ascii?Q?hzwPmptZQfYHSU06nIrJEJZVZLRX3/R1TO2dGN7gd2SS3F8MGcyzHKwnSmg1?=
 =?us-ascii?Q?LwdCFAN+ttLxMZYMupMmEyzmySUAoI+fzCaslg7xcGCnmMEIQbe9XGmjwxaf?=
 =?us-ascii?Q?R/Dl9GOm41dxVB2TCrZGEjYZQ0w29y9cnlJibXN6mvwgQFiceVPcrWOf0Y6+?=
 =?us-ascii?Q?+yUow+Dyd+ipxzb1j66xcGF8XyvOMlTOhtBkzE5ILmV/wXKwJjYSCTJKaFcs?=
 =?us-ascii?Q?XZVMYpax8jvkFLnki9ks0HIHax2fQ+LrzMeFiJdZDPzSWa+a0EQDxT0olgq+?=
 =?us-ascii?Q?yptAzaAvT0u8zEwkh2DfPt1/s/d9evjvswvG5sSZmkCl3qd5YE1b/vBtHtHD?=
 =?us-ascii?Q?px1VWEdak45rljF58eGg11NIHhEIYnZtIUDX6BBpw/gEnPlQajuxBYtDNmlJ?=
 =?us-ascii?Q?icxYIy6Z1eBDJ5muQqZIY5x9/PgnYGCJqt+O1xPO2gX9ckPyF04BNvov6iK+?=
 =?us-ascii?Q?T/bz5/Sfk97wPADZYzBPOKA0x+CX8w02HWQ0H4xqdxgiwnZ4NMyiHJJIEKxM?=
 =?us-ascii?Q?Xi7ix5744VGvFBXE25qX2YJHDdsrEpTZY25/CCJG0pTO2VuGbiY+c2c5FZwO?=
 =?us-ascii?Q?B0eP+hUNjjZJCqZNw0HPs4HaxlLokFUXST2ke2Wna1oYw21LBO8WX2JHYcnf?=
 =?us-ascii?Q?QbZRW0v/NdNopj2chCJl9Vu3V3HzW0+bLmpyj8xSeWhwCtlUTF9O6CpzbQPH?=
 =?us-ascii?Q?dsn0zD2DlQP06iZ0ZkQijEf9mNo4ltrO5r3PfMQGAmN8boEgd/0pWWlTGWik?=
 =?us-ascii?Q?t9tuJ+n5uyfln64lDEB8wmIxhgo7gOw9hJm/flqxkyaIeF2CSz+95I+HIPKL?=
 =?us-ascii?Q?K5hLc+s0r9q/yB0z+2iZBzvDAfL30/GU+0D7Tbi/Vfs2Cf/nplyAVA4BFq+4?=
 =?us-ascii?Q?lAi1rZ5lvae/3/mffieL3bfObxxWswtaZKQ2gr8CLM5kB/N3Fa1epgYmrYm/?=
 =?us-ascii?Q?U1GovV7BUawP039Q/uhx0vgaD1iVdMKULStwOnPO/7qdntOtMvjS2NonaQlc?=
 =?us-ascii?Q?rRk49WtuZtC/2nDUiqd0ID6m60tJr+Tx7cHsn9CsvPb4Y1vORR9YrWrVIjdv?=
 =?us-ascii?Q?yr3GM4yezQlIsBpy2aHXN8QNEv+HsLVnDUkuIWmFcMdvqI8qxlDIH2y6QZjN?=
 =?us-ascii?Q?fjDu2Q17dCLlnCpnNwYl5saIEjN2T6/0fj+Me8Wo/PnG82EtqX5vSkLUThVX?=
 =?us-ascii?Q?NtIx2BmkdoocjateGGPiaDEoM/b+RLghOW1tA24j5P3UoSt7mFXcIL7nOKn7?=
 =?us-ascii?Q?hvoMFcU+gtwRWk+MSlMvD7OXX7ZXw7zldLoyX+ThSYZEvwcpX1Oylq03zRjz?=
 =?us-ascii?Q?1tRTrLvdUCDVxq4GNB3tXwH4iWdxO7qKEJVGqb3VuzQPaPc8hKR7Ex3Epfpv?=
 =?us-ascii?Q?kqXqdW3/2CxqBrqQgHD8YQ2VJp7uaod9ePY99KlZdNsgHDIfmK/1?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e4bc8745-2766-457c-8362-08deb70352d8
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 06:36:43.6748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vS6pl17e/fdJdN41fpwJZvjbwHDq4qlGRojNHjNAoVGnpl0MupdEH1lyhfhuXSvIQlucNb1rdWRiSpoAP9QfjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6P286MB7399
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10609-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:mid,valinux.co.jp:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BA55659F8FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This is part 3 of three series for PCI endpoint DMA.

The three series are:

  * part 1: dmaengine: dw-edma: Prepare for PCI EP DMA
  * part 2: PCI: endpoint: Expose endpoint DMA resources
  * part 3: PCI: endpoint: Add PCI DMA endpoint function

This series adds the host-side metadata parser, the pci-epf-dma endpoint
function driver, and documentation.

The endpoint function exposes selected endpoint-integrated DMA channels as
a separate PCI DMA controller function. The host-side dw-edma-pcie driver
discovers the BAR metadata, requests the final layout, and registers the
exposed channels with DMAengine. Host clients then submit transfers through
the regular DMAengine API. The endpoint function keeps the metadata BAR
stable and uses a separate DMA window BAR for resources that need dynamic
subrange mappings.

No fixed PCI ID is assigned by this series. Users provide the PCI
vendor/device ID through configfs and bind dw-edma-pcie explicitly, for
example with driver_override.


Dependencies
============

This series depends on parts 1 and 2, applied on top of pci/endpoint:

  [PATCH 00/12] dmaengine: dw-edma: Prepare for PCI EP DMA (part 1/3)
  https://lore.kernel.org/all/20260521063115.2842238-1-den@valinux.co.jp/

  [PATCH 0/3] PCI: endpoint: Expose endpoint DMA resources (part 2/3)
  https://lore.kernel.org/all/20260521063405.2842644-1-den@valinux.co.jp/


Note
====

This series touches both dmaengine and PCI endpoint code. I kept the
dw-edma-pcie metadata parser together with the endpoint function so the
metadata producer and consumer can be reviewed in one place.

If the general direction looks acceptable, the dw-edma-pcie patch may need
a dmaengine Ack if this series is routed through the PCI endpoint tree.


Tested on
=========

The RC-to-EP data path was tested with a small out-of-tree DMAengine
client. The host submits a DMA_MEM_TO_DEV transfer through dw-edma-pcie,
which uses a DesignWare eDMA read channel to copy host memory into
endpoint memory.

Tested with:

  * R-Car S4 as endpoint and R-Car S4 as root complex
  * RK3588 as endpoint and CD8180 as root complex


Best regards,
Koichiro


Koichiro Den (3):
  dmaengine: dw-edma-pcie: Discover endpoint DMA metadata
  PCI: endpoint: Add DMA endpoint function
  Documentation: PCI: Add PCI DMA endpoint function documentation

 Documentation/PCI/endpoint/index.rst          |    2 +
 .../PCI/endpoint/pci-dma-function.rst         |  182 +++
 Documentation/PCI/endpoint/pci-dma-howto.rst  |  200 +++
 drivers/dma/dw-edma/dw-edma-pcie.c            |  369 ++++-
 drivers/pci/endpoint/functions/Kconfig        |   14 +
 drivers/pci/endpoint/functions/Makefile       |    1 +
 drivers/pci/endpoint/functions/pci-epf-dma.c  | 1361 +++++++++++++++++
 7 files changed, 2128 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/PCI/endpoint/pci-dma-function.rst
 create mode 100644 Documentation/PCI/endpoint/pci-dma-howto.rst
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-dma.c

-- 
2.51.0

