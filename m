Return-Path: <dmaengine+bounces-12185-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CovCLQevT2rjmgIAu9opvQ
	(envelope-from <dmaengine+bounces-12185-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:24:07 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A2B7322FB
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:24:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=vivo.com header.s=selector2 header.b=mMPW5YbP;
	dmarc=pass (policy=quarantine) header.from=vivo.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12185-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12185-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8A70314D29E
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A2842B316;
	Thu,  9 Jul 2026 13:59:21 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012026.outbound.protection.outlook.com [40.107.75.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE58427A0C;
	Thu,  9 Jul 2026 13:59:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605560; cv=fail; b=mVZH0Q3brzCU30jAMzg24CKwPrL2YtU67eRqrSkeVh/pmxfJgQMwc3xfie7xcwBnemrNdrgLM//hnwbvDGN39wy42epfrEQM2Ri55QxO9mCwT6MkOOr3Jv76aJL0KFS0I2bVpP26eCraZhLcPx20tAAkrOrPQ7YogLEOCzUUOAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605560; c=relaxed/simple;
	bh=vq96bkai+C2ThFfSKIeEmtXVODc4a6vnwDya1s2mMfg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uadHsjy42woba6/r3Ij2/by3x6IyffI905rHgSjfg1Bce2LwhTn9hsnoryTV77xbfLsny8wHR6dwoXBYf1kPwYzcftCKR6k0R5epCWMQ3LGJCBb7fEwLEGviTvPpWiFR8NVYMcD/us90aQBfZs/NhcL6xDdjsIu3QB0h4DR87c0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=mMPW5YbP; arc=fail smtp.client-ip=40.107.75.26
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zCSACtPIeWM429/Oyi51l/pu14Zg5T0fE8w5TuVFKrs4BCt/SLiIWEmsW+DOH/v8CRs3X/0AWDHtvDAru49UNOAut/pMSQAJSAWrGbZiqPJcdhLH7xA4fdnmKXMVr9bJNUj9hBV2b3Jjkao6ttAFGPLHMbkIwnXCg5UuBlim3EM/BPcmCGJsaPFH2IO8RiWGNzBhE5tnvpacoqoQuowlEASibYpd+rI0uFG4/cPkVx6webEVMsP0XfjHXmCocTbwPcSilJVWXHSe4+wl4QDpOlmjnHXkUWVJZ/kLlucY93HclQSj7R78gjzQsob93l/DYJ9MTFKVzu9PoFmkjtDiKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3A0j+TJyK3FyUE34bAMEHu2ckw+gd2tDJlW2OfEgveQ=;
 b=v9Gk99hWUvgb+RJbYJ6YcgH/GMf2//YmccbNDdRS0b5ZCEtj5LFjM4qj9aBuUvf8eE4OdIdMgrI0mJj8JUF8QxwSzWOsiTGyzWmK8QIwKYjZsJfVi+NpcasmuHU0v1k5/UyHT4W10edmdLIKYgdblRS85TEmGgRxzgpXb5g8CB2kXt3L9n91F5VtsfpXo4RFJkQdbcU4MUeBp5APjHXx6ytMDYbP6I8rxFYc7UCki08yFqqqsb9xkmnn29RFe5Wx9uycNPKd/7rkaqty0CS6U33U+1B88X0tnIepBi2L9lDtOShIHr7WOJOPRALXmL8JncqIcU1Wr98cAkV8ns8X1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3A0j+TJyK3FyUE34bAMEHu2ckw+gd2tDJlW2OfEgveQ=;
 b=mMPW5YbPbKJljqnq/qaXTv0wJOPV51xufGw7dDkP3KGpwwhPX7DLOrK1JCoKXb6fBx3iSTR3Udr48YeX/wk5AGhPB/tvRHFFC/2PYtlG0YUwpZQE/W/h9HGPCRHMZWlSze4qDt9Qpyl0i62C/5jfb75oQKel93jgw/eSpJUffDkcUjvAWP7CVXeZKeVMyZsYL82srC+1C+aOXq20C7ZaiBGBacgOlXcu1uyOzGxyJJyr4HQw5oCoaSX6NLmMhFc/7QWNQ8EkA7fkxoUK/qOCyVoHzyYDHdeI4hxz7PcYFjYctb4v8q1IFdCJeL/kdpq4F80MGJbrEfEEQp5TVkspsA==
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by PUZPR06MB5673.apcprd06.prod.outlook.com (2603:1096:301:fb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 13:59:10 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 13:59:10 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 06/26] dmaengine: mmp_pdma: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 21:58:10 +0800
Message-Id: <20260709135846.97972-7-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709135846.97972-1-panchuang@vivo.com>
References: <20260709135846.97972-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0073.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::11) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|PUZPR06MB5673:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d5971da-9581-474d-83e8-08deddc2404b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|23010399003|22082099003|18002099003|56012099006|11063799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	MQFYryrQa0EKHVNroBVixP8etmgfrvSVN2yVVYP+SJtc2MDgcNUZDS0Jigl4UkxsDBBGHwLpmV412tfl+O/cWxIwXgEXYqcv6eDmLmtwdaCcO5+DdC4s4cLh1b7G2oEllMLpwwXxHJt9gt82sIhJ+8rdUlOH5lxV53nsRUO7iAW5JLYRxVjguRbeFsnzHTmwx4TzGx7RGfdt37JJB/9TXzJwrEDWeXyuR+wOfnzZ/FaXpWUNVJHEVxcj5t2UWRL79ez0YRJ+RZJ7wdLRkE6Fmko1SkfRHwKdnxEgckFjdSQBHazgicVHvJ1v/69aL2Go1nIlauVKPUo8N66poxFKed2tlQNS21z+kE/lWN7k51hA+mVklw62svh9mt5WpjaBMkHQQYE31TX9/jJ0RVej/0QGoO0zKX2hiX+ZnDX4LbKwXfpR+FkD8MmFBAMn4+AENwSRNxRoNYrKPaDI1vSY1bhjAN2GPp1J5k2wY/WvBlO2+sBNDSIM2RcaaFyxzmfBZoB/+v82SK6UiT7FVEH78eUPknNpQsZikY8RA2wfjj0fskrM8zi7tuzt31NjHF75xQcvcsLIImB/kQQHbJARoARH02xM0UEk9iUk1x3/+39HIoyLIptto7t3zh1XMogHc37RwWHCh5vtB2SjqbPeACkvkZnDhMmg4QbjUAWpnIK295+qwQ4Y98sfb166rXDULF9/VdefSwpBbyR6hgxkv33G3EWqP1F+dQj8BpeA1uY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qmJ3RwRc+D55IQNB/JM3OayzYWqifbWLkU1GdTCgtruW9zA69AGQVHBgJvEY?=
 =?us-ascii?Q?quzxT5kci6rLjIgJV42Yyxx9y95xmUbPi2QPUAf7HrBcneBOiSElicvYOiC/?=
 =?us-ascii?Q?FeaA6YiSkAx6is6DRR7/ZgRqZJwoWVyVq1pnK1s6Ef8cfJF2fpf/BAa8PMwl?=
 =?us-ascii?Q?IHZUKp4HIvMmxPUkMKWR3jvQ7X2utg2ykBNr/NdxN4pwyTfbNJnHWQ9/emD1?=
 =?us-ascii?Q?j0amm19j+81Z6SOKs0tK6Svit3D4vVnEz2lGlO9DBfieHlSenLDcVBOWela8?=
 =?us-ascii?Q?Id++HirXIx5CZkhbASt1fz4jIrXk5iCtU3tvSUHYIH2Q7b1Z3jWjRvhiiwf5?=
 =?us-ascii?Q?Zr74KoPL9W1BqGb+98IRb73edVYVKl8IRnuI9+vLeggO4qb51zK6C4y8GE5n?=
 =?us-ascii?Q?7pCt+Su4PAZAx5saCbaMvmu8F3reZlyRuhYqcCx+zEEZ74E6V2f486tu1Py0?=
 =?us-ascii?Q?C0Td4neq7Du2+vYwaA1b4dN1am3BiLyAoKgXMvVLLzh00JZZuGjocYP17wsY?=
 =?us-ascii?Q?ChbZkstoGMQ2Kv0vF8r5JfaIHd0JJrsYRXiAetpaHo9j+EWMIMGSHP8wxoe3?=
 =?us-ascii?Q?8CDOxAETuGlKiHPkmISZE1aoIxbfrPgqEFXHT4hSgHddCfvB8S8tnF6eZUmv?=
 =?us-ascii?Q?Jrz4WYHbhbt3PEhTwSdP0YodflKrsb96fCArg6e6uhM6p8EOR5R5V4bvg+b/?=
 =?us-ascii?Q?8d7MgQJLqXtFq05/hYCKCetxehmxOb/ucA9mdSdL7tizfnzhPULWXxm0HAnH?=
 =?us-ascii?Q?2/0WtoCKjTiGX/pS+KC5HxxWaSlh6A4mI5RcSVG/QbmcsSiMcoTn2ezcgWY6?=
 =?us-ascii?Q?cOOXt4CCIZH1y2lVF796fhWB5afM0q7KNV1g9r4RBgXRUgaPiCYvYayXY82l?=
 =?us-ascii?Q?e9Uwv3flWu5mjtRAg4LgzELjvGocPraf7l2zreqy9Pt5p5avTJ9iMpPikc3r?=
 =?us-ascii?Q?w6kiwYqnc8OUu+JZ8sbMrlcjEH8R2ceY1vyJK419wAhLTbVA7OsPZwYZwy/j?=
 =?us-ascii?Q?7orBrCxhUXb5nO+gNMMIpE6zk+d96U4dETB4qhllgkiE4fOAjK3BfOhEioQM?=
 =?us-ascii?Q?6sNdUD9edvZ9ofmlGZZvtasrUPb4TAfKtJniAsfrPPT0uZ908/Jde5rhyduU?=
 =?us-ascii?Q?fSFtSq9Gm2qZGmc9VR4lWs6Fv/FxdEPsPUqme9tzo6KMMOMQJEAnUjHpTuIu?=
 =?us-ascii?Q?6kUaCHw3J+cFRPv4TF62WwZTnXZoptchcZH2JgxbLtWqKSTU3yEV0PeNkiKH?=
 =?us-ascii?Q?rOe8weCg7appY4ouHiafiBI2o0dhPPL4uWin1/RWs56ds4u4O2kA9nhAAzmv?=
 =?us-ascii?Q?p2nPgSop+UpXuFXaZNqWdwEaoPm/Jm23wQvrBM4RYAONoWneEjVhmRs+SzwT?=
 =?us-ascii?Q?ODCJWz7zQO4M0GwMvlkmMSQDgkkS8TdJsJhhPnfPmmXpg4pcU0rlFxm2khL4?=
 =?us-ascii?Q?WXYG9WcSzkdqXwQERNMdYOQ2J9w6efoN0VEzwjeX+YeUrLS97Pe09zOpaX9j?=
 =?us-ascii?Q?z2BEB474vg6mWVU6Vjn9EXP/nLfyDEJ1beMvWyKeApLF/gBH+r+YlOmhsVMC?=
 =?us-ascii?Q?TaaEDZak/VJm78M0u9mGfs/Fhz31d9hXsy5/fs5xXL5uTv279iX/kUWjN7CI?=
 =?us-ascii?Q?f+yyv4HAkMTI1yoS+WJQ1qLh33HsE4t2dP4KXoaGue3rWbMSY4KOZBgjspbr?=
 =?us-ascii?Q?5kjK+27fvClYgOn5iCz64cvE995vTAb7IjmxO6dL9JZUSPzElPWqeLiOQH2F?=
 =?us-ascii?Q?2OP9fGLU0A=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d5971da-9581-474d-83e8-08deddc2404b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 13:59:10.6986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kT2MFM8MJdMle22310nvDklrA8L3HVT5xyLmvV4KLDpFEpFbGnC9woUVeJXSK1mnc/OfNA28RWEw2m9dtIGduw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5673
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[vivo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[vivo.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12185-lists,dmaengine=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[panchuang@vivo.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:panchuang@vivo.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[panchuang@vivo.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[vivo.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vivo.com:from_mime,vivo.com:email,vivo.com:mid,vivo.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 11A2B7322FB

The devm_request_irq() now automatically logs detailed error messages on
failure. This eliminates the need for driver-specific dev_err() and
dev_err_probe() calls that previously printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/dma/mmp_pdma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index 386e85cd4882..c2a638d55488 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -1161,10 +1161,8 @@ static int mmp_pdma_chan_init(struct mmp_pdma_device *pdev, int idx, int irq)
 	if (irq) {
 		ret = devm_request_irq(pdev->dev, irq, mmp_pdma_chan_handler,
 				       IRQF_SHARED, "pdma", phy);
-		if (ret) {
-			dev_err(pdev->dev, "channel request irq fail!\n");
+		if (ret)
 			return ret;
-		}
 	}
 
 	spin_lock_init(&chan->desc_lock);
-- 
2.34.1


