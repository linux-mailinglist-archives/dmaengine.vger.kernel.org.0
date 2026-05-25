Return-Path: <dmaengine+bounces-10805-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULfwAnnmE2rhHAcAu9opvQ
	(envelope-from <dmaengine+bounces-10805-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:04:41 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A49E5C62D2
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2E4B13008C87
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 06:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE9E34DB46;
	Mon, 25 May 2026 06:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="rJbXCyJP"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021137.outbound.protection.outlook.com [52.101.125.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351A233C53F;
	Mon, 25 May 2026 06:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779689031; cv=fail; b=tLyyAxokX6a0rnPZ2ftWGmqDxNzjUX+Gf4/SRhdsrWc3Bv2CYEvdqHsuyo/GFDxo/FSJmMN3Wx7anTFdtIYichXBCg/Gvh7mqlSJFh8ovwtKUMGC2ZoxE1NNHCDNxVFzKTgADkBrZrZ3GfbUiP+N7hlVA8msV/6U3xjK/EiPBH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779689031; c=relaxed/simple;
	bh=mOslabz0fh7nG/An2hNX3VpI9R/rnk5Pj4hc3PlhvS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OwAQ7JSIO717W8WS1NckxmvjJcrCn+02KpKUBDZaJ1JjHpFI3BUKcwVwBGUw9l7vp4zvUmwha3wCMNsNehozav9LXPiYtbsZOLwW8hTAOz+NZ7xeAEH2jEjclRuoR+3dyMnSlrjrHXLsW1TJtaoRZ6s5Bx+Q5vMHb3ti7x0cyCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=rJbXCyJP; arc=fail smtp.client-ip=52.101.125.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f9ZW5AFz03H7igr4QepiJgtYPPGZXMInUxVURCaMbN2/N1vIuh8kiamuWLXV2ePLXPkqZFhyKR2NKDJc7URvb1/HA5VPltqOCN8pHKjIca2zpgwWX4/FI21qv+8AaT//h3VG+6LRkPno4bYB+J1cjQq8wNn+HbX8pUlzkQVFt3SwnboR4AMI73QDoy3547/o7gaW2mhvWN0bxBVpfrQ8dhu55Lxt42K/5dNUbN90u/C/2S6JsNjOvSendjRqiSoWyp/H4aA/h2kKGF3if+Shkgp7TijE7QrDjpfnaAFupQD96qN2Mks4rEIoupofrv8dlxAS7LSzf2P0XT2LHh7zeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LU8sjJ1MBFXLm3G1m1v5bXn9KapZho+gFi18luy3AEE=;
 b=m2M79006yWop79ectDuvfWJt7C1yCH/SFCyELptK24NyUIY0cztEK0ILImsyxkLCF7DYdepCOBwuhZySVTra+3nzlW6yX3X1rcfBZ5SvWjN10kRyswdfO5ggrjYlsuIhQY5/ms5YqQ8VsMcBpHnzpFy8hhyzRWLWYmCBkPCJcgfYTUC/3nEUFAF769PP8yxNfBHTwMC5N6IUtVDuvAVglHgnS76QsSJWtADK+tEyNQIIGTrln1cl42Ctha74/g3QZv9WwtE/qwoMfD1KKChFyCpm9QYVasSPXr82jJH44eVDhzf3HWvlOAKdsRoTqCWcrZ/GZHYgoVzyp9e7y/W5xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LU8sjJ1MBFXLm3G1m1v5bXn9KapZho+gFi18luy3AEE=;
 b=rJbXCyJP7cQIkAw97vMbfe5VoERK9ivif/Iye66oGiyTVjjp/cB1LIUycjpxaeABCc+l0z60dq25+KzXxeH5LrZVNCrfDAyocJWw+LHgly/OEPqwInEJQdg//Gq1+a3Q8+Ml7puh/2vrenqJjlbvVhTdu8+l7XovkQaoHkNnGbQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS3P286MB1710.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:163::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 06:03:46 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 06:03:46 +0000
Date: Mon, 25 May 2026 15:03:44 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] dmaengine: dw-edma: Fix probe paths and register
 races
Message-ID: <i3uiefb3lj2psapptivr44l6j3same3rqkbxvrrufrjtd7buec@jztctpbotl3g>
References: <20260521142153.2957432-1-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521142153.2957432-1-den@valinux.co.jp>
X-ClientProxiedBy: TYCP286CA0020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS3P286MB1710:EE_
X-MS-Office365-Filtering-Correlation-Id: 752245f4-4def-4088-0bb3-08deba2361a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|6133799003|3023799007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	f4bU2ck4Q+Xawnw9wKpGC7VvG1blT0YpNWNLpdhXpg11HLi59YT10z1BnRa672fS3WsAxzbK7wD9navVinR1v+CL6mwf9lSBC5HVNi1PhVCjYqawiqQUWpcXItAj3LnouyqcHfs5rMwIPBMfIiy/Rzdr/CNuJGIlFyQ0XVhHcHyhjdMUOt607+t/ODgyu5y/Jp2MUCoQkedUF8NnQGsurtWJXnDBePAHpp0BMNvymVK6jbPGTN1ZTGh5rBsng2L2kiO/KrmIdbaoweEePTS4VP1Pd4jzW4PnAa3oAadZaYS3Nh5UGsTPPdjVXh4LuUuTWpj0Giaohj20vQO8r2+IyAB6P667wHLUUhXtwqcH95u5A0igU4NJQpU/gVUK5qxkADNPBjLW4yiAGhIm1TnC7C2T63d2Rokw8OfMQfcCnxrjTY+rjTCOLXXWK/+xqbM56u07mYfYhvMf8JKwopS2bHWLXy4Bsk2Dbkfy78wP+3VhoncVURjThYeOWxU/CJiBIooHxZvnoEX8zjLZ9A7xs2UdPSKj3oLuXGghLdTW7iXl3ngcRHOER3/w48nfCT33Qr5PAZzofZhngMcYdabuUk8qDQH5AY4itPkAshh2Zza3qA7K7orPZLgU8a4dNX5+zly00Jc9L2o9vf4Mn5+ZVx5ZFONYuCXnszUcdLfzuHxxwuMrt2jWu+B93sAFuArTvQrROs55twe77hTE6C9RhQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(6133799003)(3023799007)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d2htIK1IrjiBYQap1vF69HpUF5amBhqySA1yGZGXFCUJvfKyQW/2h0AN8X4Q?=
 =?us-ascii?Q?RvPVvsI2dc8bQx6FsKqgAXBlqPir8AXFwMGgCcn6fHkNpwh2eF2qaZ2N4Mcd?=
 =?us-ascii?Q?QO8oL9CNuDLFurQ1mqZJl6LppkeGxdGTeIgcoGsmAvelmREA5unkRK4FWkj3?=
 =?us-ascii?Q?2zW9R2bzRndo2AC/axyjHnmPYbUnYfY9RXxCzwpjSz5TgMfjxPT2AQDKc5t8?=
 =?us-ascii?Q?o82YrUy9xNKxZzg2JI1JpZQAaXGlBVrbLjyTCUVKMJsczUdTVANbvdtaqQIT?=
 =?us-ascii?Q?nP8CyxNwMZdKjcHKttJ+AgGRYHaLQI2YcC4Jr2ZozFiTLwFsb2+VGxL0nWtQ?=
 =?us-ascii?Q?iw55b13p223aCIh0RAjHJITMX4vZ2/RKPYtA8F3nlOPqsmQVoD/5ROP9AnEk?=
 =?us-ascii?Q?IlGZk00Z59oVGV0G9T+b0y75dnwfu1HeMDGddvLAX+1F6UizC9TWfMoN2g7f?=
 =?us-ascii?Q?hCK2pP0eHo7CfPui5GLlT5PgSb0O2J0yJ0tiY3DlpvHymNVKN82wuGRKTCj8?=
 =?us-ascii?Q?Del05pb2njFrTCRc4TOKHPH9SGoyOV/alu52OGXE3jsqtwM1EwUNzUIjkD2z?=
 =?us-ascii?Q?HMdkiNhMUvsELylQ7jEWMcIy19HBhtYMATbzhh+lcdSliVj8wcTWJb0KUj2i?=
 =?us-ascii?Q?6kRzbJYfeM2OIHOyxatJhTnNh6lT58FbVIW+dGC8YyBjDStaUv0KgtlQX/XI?=
 =?us-ascii?Q?qjHXkmK8AaoANGqvnhKwxCS6YguUSLbDkfqx7NyQU5elWN7aqADMfkPAnFoy?=
 =?us-ascii?Q?luOOaioMYsJtQI6tCtXvlcZIJTx3ZrxQVn3kQsQVbJb5DdKu0yFiFlj/7HlU?=
 =?us-ascii?Q?LgVczsRGlXB3IZUf33L8M52yJTqKvmIDRachyDm/0E1uGIcOr3IxAI6R+gbf?=
 =?us-ascii?Q?cDJf2zQHFjR2+PgnVfqQQLVLnyc6QBbJKS0zeSHqXrgJUQrvv+zijSNFMav9?=
 =?us-ascii?Q?rG3nl+1bTohauMqWIw8n7tNVDln96RH9VChYeRx5JXdvhm5e6r0xUwRr2rvd?=
 =?us-ascii?Q?L14P9i4dvMw+J1I3TsYPhURw61qIe7SPlHaWQgM/QslrZwSJi4A3FSCDDix8?=
 =?us-ascii?Q?nDVqmeclbbqAsTvqJvp6rrdlpBJiC5BO0NyvgMSVK6Zp/LXRUJl32J11Ex0F?=
 =?us-ascii?Q?aw45ij8mUQjZu0uN/2rrh2rOfAbWXnF+FOKrORTlSdlpjWmcmFyEs9UHiwVc?=
 =?us-ascii?Q?usjAsdlbIwOXtQkyV0OkxHxj+eQ18F9dbbCVr1GI+UOOkxUGZizfQEUQtHia?=
 =?us-ascii?Q?xHjkqUIcEJMcx5Gs7MqyJvG1jvx46RNSXnEXT/2Mqt07r7zGTNacBlPRXpUc?=
 =?us-ascii?Q?I3walRbhcRWs2/Fe0M2kNZTZhjdorp7UIooLe9UoMNPeyPsZlaPBnKM70BAN?=
 =?us-ascii?Q?agL90UCGdCZQ/JZVJ2ebRIsua7CbvW6/BQH3fzawDu4ttNljNcD5LQWZiKIs?=
 =?us-ascii?Q?OlJzGznY81diNXexqvBybp9tjY9UwMEu0zQvsR3jk2ESugt8vodI0zMApv7m?=
 =?us-ascii?Q?l7/Vb2L3RruOLDXzxgBCgvXlidpgW6IBbgFronE6lUohaLYB/qPd2zQqfmSN?=
 =?us-ascii?Q?+haIY5nFmAmDHWyXu9mK6hRbav5PBkuVucBgRTq6p4ItmKl3ZMbYZYhNKu1y?=
 =?us-ascii?Q?rKJxD18QZCfNX22VH6NWp4VkaGNeXelWyGIuMGoMcVcCcTkBTlC1XQHoaFJh?=
 =?us-ascii?Q?shJtt+oy2fC6Ea1wxNn05stue8weiT98s/+dW1UGA7yn/E4j16/LBG7mFBeZ?=
 =?us-ascii?Q?+2m51zjxA56d+1NaEp6iYr5+1Y1c98A0bFUUNP73u02SHqh3yFuF?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 752245f4-4def-4088-0bb3-08deba2361a6
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 06:03:45.9370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: whcautCtUNn87G8KM9Y4THCVxiOmqOInvlPlgQoLh81y7/T9VoXrqKvXWDKENSS88NfvYRkTcHgaWZmEQIiv+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB1710
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10805-lists,dmaengine=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:dkim]
X-Rspamd-Queue-Id: 0A49E5C62D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 11:21:49PM +0900, Koichiro Den wrote:
> Hi,
> 
> This series fixes pre-existing dw-edma issues flagged by Sashiko in:
> https://lore.kernel.org/dmaengine/20260521063115.2842238-1-den@valinux.co.jp/
> 
> Note: Patch 4 was based on a patch Frank posted in January:
>       https://lore.kernel.org/dmaengine/20260109-edma_ll-v2-1-5c0b27b2c664@nxp.com/
>       Since it has not been merged, I included it here. Frank, please let me
>       know if you prefer a different handling.
> 
> Best regards,
> Koichiro
> 
> 
> Frank Li (1):
>   dmaengine: dw-edma: Add spinlock to protect DONE_INT_MASK and
>     ABORT_INT_MASK
> 
> Koichiro Den (3):
>   dmaengine: dw-edma-pcie: Free IRQ vectors on probe failures
>   dmaengine: dw-edma-pcie: Reject devices without driver data
>   dmaengine: dw-edma: Initialize IRQ data before requesting IRQs

Frank, thank you for reviewing.

Mani, Vinod, if there are no objections, could you please consider applying only
patches 2 and 4 from this series?

- Patch 1 should be dropped. As Frank pointed out, pcim_enable_device() already
  manages IRQ vectors (i.e. sort of false-positive from Sashiko).

- Patch 2 still looks valid to me. After dropping patch 1, the new issue
  reported by Sashiko no longer applies, and I think the remaining concern is a
  false positive.

- Patch 3 should be dropped. I rechecked the initialization path and I no longer
  think this patch is needed. See:
  https://lore.kernel.org/dmaengine/kjslqii4bs3g4pi22mxh72hxnlm7nkesdd3va6zi5fhmjamerw@j7lbrlq5oszd/

- Patch 4 still looks valid to me as an independent fix. Sashiko's feedback
  against patch 4 also revealed a broader in-use unbind issue, but Frank's
  original path fixes a real race issue on its own. I am not sure whether we
  should add in-use unbind support right now. See:
  https://lore.kernel.org/dmaengine/ne76elxedfnngi7dilpyvpzwm7tghyj6kpg4ninwxecxsajkkx@zkarppyurl2s/

Best regards,
Koichiro

> 
>  drivers/dma/dw-edma/dw-edma-core.c    |  3 +-
>  drivers/dma/dw-edma/dw-edma-core.h    |  2 +-
>  drivers/dma/dw-edma/dw-edma-pcie.c    | 42 +++++++++++++++++++--------
>  drivers/dma/dw-edma/dw-edma-v0-core.c |  6 ++++
>  4 files changed, 39 insertions(+), 14 deletions(-)
> 
> -- 
> 2.51.0
> 
> 

