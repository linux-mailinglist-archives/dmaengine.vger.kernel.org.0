Return-Path: <dmaengine+bounces-11648-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HCpYIG3HNmoTEwcAu9opvQ
	(envelope-from <dmaengine+bounces-11648-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:01:33 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D03F86A944A
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:01:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=SBDxriES;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11648-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11648-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDCC6301349A
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 17:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F2E254B18;
	Sat, 20 Jun 2026 17:00:59 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020101.outbound.protection.outlook.com [52.101.229.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEB02772D;
	Sat, 20 Jun 2026 17:00:57 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781974859; cv=fail; b=Me1WJ23w00FeO5J1yUlvkNBHzXuX8rjQYjav+wO1H/gbI9oCqh60nsKE2IFniNHcd50olPzh3YhHBooWzTAVXVXM2so7KAiy9zqc5nf2+zlGBw18p+Zspr6zRa2G5hUSX12pqjdZQfnoccrCkhUWFswCBM6Oc2PkpjGBBjidPM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781974859; c=relaxed/simple;
	bh=/TDSDTzfQMKdnxVUYKKE67XKZR3mfiVbw83pxvqaBuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JLnj5i5z5SajKkCOt4NhJ/jm51xIHj66uqyngbzZWs45/EnIqd83L6904RrmGD6LZ/cjomHrH+VwGC4mk5APBN5bgas5gRry5EjflnzmpvGXia5/vaFkFl9nDgnelw5koUziyeAf903+4FS/Oua5HhMnyh6LuH5ZpZt0Z3axRMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=SBDxriES; arc=fail smtp.client-ip=52.101.229.101
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dEFRlOKRksruPinL/KQhERjqQ+YDRSV65Bn4cO5m2DqWkMe9YwNF3M9PiV/tkt6xEpBoWonTipFo5b0BBH7T4doI0cyHji165F/7pWzNJBVr74vAmMMQZ0kCXxU7QYq0xyZdi3v1bVbqs4mmw1EhUrIGOacHtYC6u6JBLCV7xycWeV0W88lp8a2LMmTkVfpZ2sex37LHeUEpUQaPwsyR5SKJ6UlkFFeIjPW/2stpjjKETmF/cj4XpbP2rOC2SK26Ijtv1LFAwDxAYj3hCs7nOMx6HZ/P7lApssiFPs+ohJv+aZLRIEqW8WWFDZmqQsgi3TJHEUx5aJL7El7b5KH3Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19IwCLbSHgfF5HArpderFL9IfDW6yDlMqSMxFMCD61k=;
 b=DR/VLLS5gpMShI1tl4V4KEOfbB1S6YDAgfVygxLXssFOTcDF5hn4jakIUHAITCVisMDuVPF7HJDnnAlRjLuKeSWXzfFGWsPLX1FSaKRNH80xoOJA7vOLowkOrdV1Ff/JL0vU92iio+aXVoOQ7xYgc5DGJaPFjYD/sYycwV4I4MXg/LlxF+sqIb0Zn0VmTHvKhA7cA9M/uHNnVjYf4sB3SYR1N3dJVlDSDkxOyAHO2ojD0w4jmjQYhy+obnGSxh8FgpmxTM6WoU7fRWHPwBnEdqes4WoEkbwiGGlvdFB68dfO4Lqn76BO2IZrqg/oTvAChE7ozG5DbOADc6VWgvVMhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19IwCLbSHgfF5HArpderFL9IfDW6yDlMqSMxFMCD61k=;
 b=SBDxriESg0kQuKKsRIoTZAtF6QFHJDNiKlEZE4nxChUQcEDr1AiSRPVGVLd1+lXaPd6PMSTw8MCl4gAV9ZuNdi19LwBp7rtnlcmhPCqm4bfp95IeSm0tSKPgHqq7txt3JrZXSi/G1RPayxQhx3+hiSESntaCmNAksGoHKXq+U5E=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB2673.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:254::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Sat, 20 Jun
 2026 17:00:55 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0139.009; Sat, 20 Jun 2026
 17:00:55 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/13] dmaengine: dw-edma: Add core quiesce operations
Date: Sun, 21 Jun 2026 02:00:29 +0900
Message-ID: <20260620170040.3756043-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260620170040.3756043-1-den@valinux.co.jp>
References: <20260620170040.3756043-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0034.jpnprd01.prod.outlook.com
 (2603:1096:405:2bd::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB2673:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f6180c4-790a-4149-bb1e-08deceed7e3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|10070799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ndBakYq0bo+LC2+ESOdMLvbHI+bt7GCFfpetNVw71Ygy2f0BzXZefFnTCf1Cu4/wMA0KQ/+cj+1zuWnirt4h/ejt0wpe/ydJbGn3aks8QHcpfxU9LPf24eVEy8hEzeGlm/+0/0clLYNJmUY49sNNMcO9iwiwoCi9VDnfnpB7oSh7d/0y9RZcRpYmR47xHj+GYOCDa409ccBilYBjLU7R82iJplbKJpR+8D3dk6aejaF+F/IsdSZtBpAZiQ0rGtfym5wCj3pVO1UrWAswWb1VeLjaVqZ1PPCtVYWMT6ttK8gY7qBcs3JJqCvmrJ4VsFK9nRtU5zdRs251Q5Gx81T9eIiq6iHnfVF5oGFKUl4DHxR1M5gvWZKW+cQym8KX105s/5ERHh8FEOVnjm7Fh4Z1Z3j7QtOnKe9I7oM98LRb/PRlW9rjWvAnG9U0oZ70jaq28TFe/smOApjBLu1AKFZLXvAM+XRJBhjVbP8F+9PnRDSMsJ3ksiiTFOqrFKJQCuiroRQTDbekmv85wpWeQz68xyKAtT2ygBLM0x3pBJ6aWIGDfDZ6qDVs4mKmvNKSdb6shreL+WJcDB69JpOyiBKsFm4oFk617ZijECcFjXgFKygn6fhyh4lNKjETH8glcwwv6WeyGJah1FMNqGPMOL19eh9BklPBYAUUfOLzq5phoMk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10070799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zD/0dBV/jAeDxxtP1xe1Rm7HPcJeoMnI48hCF2f4ylpPRLYPorZUdpoAuq+I?=
 =?us-ascii?Q?PaSjXgwO3Kqsdle/V7Y/N23dpN4+CfhTJVg0ZYiMgemKGdBRLRbYQRDwUmjV?=
 =?us-ascii?Q?NNMMlN3GrHhAurexQqc/aEjtfW6zFl9JaBF8+k35i3p+ADdPzTwLsIEs42r8?=
 =?us-ascii?Q?AzcF+aXXM0RaWb9/7Ez3/702IgB3Yeb/jkZHhG682Bzj5amcf+T7f77TkE04?=
 =?us-ascii?Q?QL9QHhmJKpEwgbZKMSTqImJklppUCMHfdLSTL5eN6HpmTcNnwvjOxaUcaBgt?=
 =?us-ascii?Q?owGiSkK2ndtQhMLuQtKYP7wj5TKe5xIT4VLBvHWBZixkxe5nV9gO13N/B/BO?=
 =?us-ascii?Q?eT3vOJSYPPspYjp6G0cHv/cCaN40362aDH935hCQ99jWqr2B4ltKQ7hthoUU?=
 =?us-ascii?Q?eNBWOkQrmbXMHLY8LtrwHsMkVnD+eQPPSPPEFNyNlevXLfcCr44Trva8R1dJ?=
 =?us-ascii?Q?48O8AYlOFmLWKoIBOJt84QLlnNd7fVOTjcYHfrYeMyRku7MTX/bWmSw5KNKF?=
 =?us-ascii?Q?chbLoyvaZINUnom8D2yNpVEePD6uI+9G9rl7Gwwr9/n1eIg7ePLCXbDNGUPH?=
 =?us-ascii?Q?O6YVDTWyAa7TWysYLH6S+CCqYyHN96y62d6T0Fd2YyKXVoAlLOnborQX9QX1?=
 =?us-ascii?Q?8OnApewkhxlZEjZ+abgdUkviWTEWhehBGkbKDI8XbKbftCpL1ZczOPJLOBjm?=
 =?us-ascii?Q?xHp5r2VhhIg/dBWlrQlCRb9Fuvvi2VosLuu3vhu0RJtf5jpmVShf+WMR9hgY?=
 =?us-ascii?Q?O4nioNgVXQOK3VrLOEQ/vzB0l85GZMMfYXnUaJ/B2CNW661e4ma8L/H5vMDh?=
 =?us-ascii?Q?XHBxmE5V58ykj/gkakWPgSmTO4TNopYUcIJ+TBAjVLMrVBnPT/o0N4TkZmWh?=
 =?us-ascii?Q?Kt9xIqRlJia1j866QrF/0RMevsrOkfkKuypuAFSaTFBAooGVEpetfVHq9XEs?=
 =?us-ascii?Q?ZyE/DMQ1SGgrsTFeUhE7eJrlnpY0s01gvAju9UFTOHnztL7j291XuarplmG7?=
 =?us-ascii?Q?CdDqvawDgenGJ/2MkRHPn7eL91fbVRUeitXHE5UpP7QyEWzQRw/NSCMXM8RP?=
 =?us-ascii?Q?eJpW6yaNnmKCB0JI0pagllMaH2SL5Fc282QIYVI0gSXd8oXKnDMtjTDVAlIZ?=
 =?us-ascii?Q?TyQEIuFVr6LI8lmprxXnTWEVI8L0kjKQa+GsY1pGuMRRkixST9bFOhmf5IKz?=
 =?us-ascii?Q?pbBvnk8pDuD71/GpOwSsx3c7/cE+BsPijwarHqz1XP+bnJPyDsNsZ4dvf3vU?=
 =?us-ascii?Q?ZPruk9q6lRgtfvJa8WqNv3CedGsa+tPf2iTrgKaYx84CpIYLZFU0fKoeEvFH?=
 =?us-ascii?Q?2ESYYBUX2bGFRBeblw0FVAgBwhGIsZ4piFKfwC9YCHRTsjRisI0KmZaY70CM?=
 =?us-ascii?Q?JOF8V6wBW9sns0GXxVGHLEtetY0qIAis+U6uU3GXJ5JAP9JLwPRJ0RH+PTgo?=
 =?us-ascii?Q?pXJjocq5lBSAo+dU8sKdTwQxuveoQy3PK+Qxp5JmlwVwkvE3Iv/Efvc5M4km?=
 =?us-ascii?Q?z41ckjII8UVWVhp4t/4e37Frdk+GkunDdxaz4nunXGt3D3qL57iXrAoQxlsK?=
 =?us-ascii?Q?MxKGxPFfyTzVZ1GeBbc1OvJ3lnASeMEjV1LUh4mtxhfArS4F/7mP0IIQXln/?=
 =?us-ascii?Q?BZMZSD24UyYE0AnDdvyQXabiGI8VQydwKnudWijpZDz3FzW9CmaFRm0BG8TX?=
 =?us-ascii?Q?B9imRFXIGXlZKYqfQ/1ym9sTOxTzYoubM/6NJkfW1llEsqKsH8jbTX2QB1zM?=
 =?us-ascii?Q?V4Oh4bjd+5cux2S0hFFtWwDa93fhVYNROzKtBrPMOpGRAPZwwwwj?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f6180c4-790a-4149-bb1e-08deceed7e3a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2026 17:00:55.3983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YAbDHvTN4lUhC8tUGEsDec1UI3mzBo+hWFKW+/GNXWfEVLMdljeo+kwaWiCc4MGEkVDZP/qApFuFJ7SF+XK5/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2673
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
	TAGGED_FROM(0.00)[bounces-11648-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:dkim,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D03F86A944A

Add core operations that quiesce only the resources represented by a
dw-edma instance, separate from the existing full controller off path.

For v0 eDMA and HDMA compatible register layouts, quiescing one channel
must quiesce the whole direction because the enable and interrupt
mask/clear registers are direction-wide. For HDMA native, the operation
can quiesce the represented per-channel registers directly.

No caller is added yet, so this is a no-functional-change preparation
for delegated channel reclaim and partial-owned remove paths.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - New patch. Add quiesce primitives before delegated-channel release
    and partial-owned remove start using them.
  - Note: Devendra's under-review "dmaengine: dw-edma: Enable HDMA 64R/W
    Channels" series may require a follow-up rebase if it lands first.

 drivers/dma/dw-edma/dw-edma-core.h    | 14 ++++++++++++++
 drivers/dma/dw-edma/dw-edma-v0-core.c | 24 ++++++++++++++++++++++++
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 27 +++++++++++++++++++++++++++
 3 files changed, 65 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 42f2f25ef377..f9d4e0411f8f 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -122,6 +122,8 @@ typedef void (*dw_edma_handler_t)(struct dw_edma_chan *);
 
 struct dw_edma_core_ops {
 	void (*off)(struct dw_edma *dw);
+	void (*quiesce)(struct dw_edma *dw);
+	void (*ch_quiesce)(struct dw_edma_chan *chan);
 	u16 (*ch_count)(struct dw_edma *dw, enum dw_edma_dir dir);
 	enum dma_status (*ch_status)(struct dw_edma_chan *chan);
 	irqreturn_t (*handle_int)(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
@@ -174,6 +176,18 @@ void dw_edma_core_off(struct dw_edma *dw)
 	dw->core->off(dw);
 }
 
+static inline
+void dw_edma_core_quiesce(struct dw_edma *dw)
+{
+	dw->core->quiesce(dw);
+}
+
+static inline
+void dw_edma_core_ch_quiesce(struct dw_edma_chan *chan)
+{
+	chan->dw->core->ch_quiesce(chan);
+}
+
 static inline
 u16 dw_edma_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
 {
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 1781ba4f022e..316d8c94eff9 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -160,6 +160,15 @@ static inline u32 readl_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 	readl_ch(dw, dir, ch, &(__dw_ch_regs(dw, dir, ch)->name))
 
 /* eDMA management callbacks */
+static void dw_edma_v0_core_dir_off(struct dw_edma *dw, enum dw_edma_dir dir)
+{
+	SET_RW_32(dw, dir, int_mask,
+		  EDMA_V0_DONE_INT_MASK | EDMA_V0_ABORT_INT_MASK);
+	SET_RW_32(dw, dir, int_clear,
+		  EDMA_V0_DONE_INT_MASK | EDMA_V0_ABORT_INT_MASK);
+	SET_RW_32(dw, dir, engine_en, 0);
+}
+
 static void dw_edma_v0_core_off(struct dw_edma *dw)
 {
 	SET_BOTH_32(dw, int_mask,
@@ -169,6 +178,19 @@ static void dw_edma_v0_core_off(struct dw_edma *dw)
 	SET_BOTH_32(dw, engine_en, 0);
 }
 
+static void dw_edma_v0_core_quiesce(struct dw_edma *dw)
+{
+	if (dw->wr_ch_cnt)
+		dw_edma_v0_core_dir_off(dw, EDMA_DIR_WRITE);
+	if (dw->rd_ch_cnt)
+		dw_edma_v0_core_dir_off(dw, EDMA_DIR_READ);
+}
+
+static void dw_edma_v0_core_ch_quiesce(struct dw_edma_chan *chan)
+{
+	dw_edma_v0_core_dir_off(chan->dw, chan->dir);
+}
+
 static u16 dw_edma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
 {
 	u32 num_ch;
@@ -546,6 +568,8 @@ static resource_size_t dw_edma_v0_core_db_offset(struct dw_edma *dw)
 
 static const struct dw_edma_core_ops dw_edma_v0_core = {
 	.off = dw_edma_v0_core_off,
+	.quiesce = dw_edma_v0_core_quiesce,
+	.ch_quiesce = dw_edma_v0_core_ch_quiesce,
 	.ch_count = dw_edma_v0_core_ch_count,
 	.ch_status = dw_edma_v0_core_ch_status,
 	.handle_int = dw_edma_v0_core_handle_int,
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 7ba6bdbffc17..63c30a6eb88c 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -70,6 +70,16 @@ static u32 dw_hdma_v0_core_int_setup(struct dw_edma_chan *chan, u32 val)
 }
 
 /* HDMA management callbacks */
+static void dw_hdma_v0_core_ch_off(struct dw_edma *dw, enum dw_edma_dir dir,
+				   u16 id)
+{
+	SET_CH_32(dw, dir, id, int_setup,
+		  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
+	SET_CH_32(dw, dir, id, int_clear,
+		  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
+	SET_CH_32(dw, dir, id, ch_en, 0);
+}
+
 static void dw_hdma_v0_core_off(struct dw_edma *dw)
 {
 	int id;
@@ -83,6 +93,21 @@ static void dw_hdma_v0_core_off(struct dw_edma *dw)
 	}
 }
 
+static void dw_hdma_v0_core_quiesce(struct dw_edma *dw)
+{
+	int id;
+
+	for (id = 0; id < dw->wr_ch_cnt; id++)
+		dw_hdma_v0_core_ch_off(dw, EDMA_DIR_WRITE, id);
+	for (id = 0; id < dw->rd_ch_cnt; id++)
+		dw_hdma_v0_core_ch_off(dw, EDMA_DIR_READ, id);
+}
+
+static void dw_hdma_v0_core_ch_quiesce(struct dw_edma_chan *chan)
+{
+	dw_hdma_v0_core_ch_off(chan->dw, chan->dir, chan->id);
+}
+
 static u16 dw_hdma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
 {
 	/*
@@ -362,6 +387,8 @@ static resource_size_t dw_hdma_v0_core_db_offset(struct dw_edma *dw)
 
 static const struct dw_edma_core_ops dw_hdma_v0_core = {
 	.off = dw_hdma_v0_core_off,
+	.quiesce = dw_hdma_v0_core_quiesce,
+	.ch_quiesce = dw_hdma_v0_core_ch_quiesce,
 	.ch_count = dw_hdma_v0_core_ch_count,
 	.ch_status = dw_hdma_v0_core_ch_status,
 	.handle_int = dw_hdma_v0_core_handle_int,
-- 
2.51.0


