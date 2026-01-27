Return-Path: <dmaengine+bounces-8518-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFJID2IyeGlRowEAu9opvQ
	(envelope-from <dmaengine+bounces-8518-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 04:34:58 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F12AA8F9A9
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 04:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D801230137AA
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 03:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6981F21255A;
	Tue, 27 Jan 2026 03:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Yxulm3lX"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021079.outbound.protection.outlook.com [52.101.125.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D143090D5;
	Tue, 27 Jan 2026 03:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769484885; cv=fail; b=WkiPV7d3QW9Z0c2dUbVkVsvxHaC90OG5QLeyzAURCe5+ObbwtlQK4hIgyS8qfuZumLGEkknXc7GBy/Z5w+K5DGA6BERHW/xj6KHO6c0EgY+eeSnZC6O6m5odb5Yxbn9WAlhGhFlVrXVdEbTpkC2i9uUbM5s0O9tew/nY2eJwkNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769484885; c=relaxed/simple;
	bh=51Qf6qtqpHPSrOevyQgT2E7D6WnkVcrLw44/aVXHoCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=anf4rq88Tlw2O15wEbfMq7q5VPjXbIT1kmsiSthjRQNB4eP50O1dh8RjSY5AyTOVGir/XZSK1tfxEVTZZx89RTh1g0FQIGVOth2VbKEVO2yczjLRyjEXaMqW94ZS2ZUQRLLT+31xZ8LOL/64tp/lrYcWDj2dFCh8go1MaE4d9r4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Yxulm3lX; arc=fail smtp.client-ip=52.101.125.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HXp6SGFmkC+knNGCcMJ712Agp98O4zjuZoKXREGugwif1fZfBm+FsfM/p4zmTnQM8Jyb2LljSLl21I5FnJr4ngiirC8BgNXzgQE4ymK+IL5sTBXb9qQodwHBn7x8FnTUbgAjzsgUZrvSjQf0JW5aHngfgMbgy0JHlQaLjdsMIMLaQMyy6STWMJ45pj4Czf9pS2zmGes0FJWRc6dF6uzWjzb/avIIa/ktfUi8iyw9TuJMB8tY6yLFKSWUqwXihM9xNwob7Hr4QXs8WGv6ywTok0CGosE1XwF0cJyt/MMA7895K+xbOHNckVw+V0NVCR5gtWisFijpXpPU0bB8S3FnKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dxSyS2mhCqhW3G6O9AwHIc0j2k4qcGaEtcjBNZM1SLE=;
 b=Mlsa+NvhjeIqFJcsNuGQByBpnLDuq4khkabH3HnrsInc5qYfEBYkeEIPj+OsLHXEpUrVSiuF0IIVQhrSLOBcYgxRCBTXkdWZHaD+XVBxDXOPBJYNYlEDBTi7KBRNi1U3D91ij2ge71jUTO10NiUB0olnuWU/uPQUf6/IQ5UKJqaamEHF+psNRwactbz+guK3044O9P+6Ohf4Kf6Q4gv3L80Rt3PVOLW45mOCU1jifrAnXWFEwH5C83l+/2AUpDdWlzZoDlE61ZzgShcRFJ91UBrwt/nIDfFHhZqFUIsfKsQadjCPusGHHMrB26gktUmIpzcPV0pDHKZN5dOwuozf4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxSyS2mhCqhW3G6O9AwHIc0j2k4qcGaEtcjBNZM1SLE=;
 b=Yxulm3lXnBZ67xlJRb8SvNv0Apwa/aj6GyLbKfoQSImSLGXT+6VqpeVYtjxOgH+f1YIJK6HD833HMvFrcEAY0jd4hQ55AI8Oji0/aAhp8S9hx23BQ/XywsEViPxLxnodx7afM8SgCcPfWmZin8RaTbu+qqLCEGrLPxgq71dkC8I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSCP286MB5626.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:3c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 03:34:41 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 03:34:41 +0000
From: Koichiro Den <den@valinux.co.jp>
To: vkoul@kernel.org,
	mani@kernel.org,
	Frank.Li@nxp.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com
Cc: dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] dmaengine: Add hw_id to dma_slave_caps
Date: Tue, 27 Jan 2026 12:34:14 +0900
Message-ID: <20260127033420.3460579-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127033420.3460579-1-den@valinux.co.jp>
References: <20260127033420.3460579-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0028.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSCP286MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f0b571a-c403-4b1d-8d2b-08de5d55016d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DXMMpjJL+LjDeZ2Mk59Cgsr1dtny3aBrmE1nB85WnbWEIvLHxiYkXcHQIiDU?=
 =?us-ascii?Q?LBUHUxySsbdH9tzvRA/MNxf6y3xP+VwHLyBWEmVIUrtJWNO/ii+QnWxdGe2B?=
 =?us-ascii?Q?xQJvqWVcabttQF46zOzo7fEMban40/K0MyuhMjc1zQjGavz3kjvzniiEj64r?=
 =?us-ascii?Q?INzek8mFjem1o15+dAESCf4fm9V5uI6O6lnC+qUZOEkg0iGaJqP18FYPuSWm?=
 =?us-ascii?Q?tOE+YU243e4G3b95hOaNZSy4wvEbEIhVWGehhOwmgadHIG0Db2LZyOzdFylZ?=
 =?us-ascii?Q?97hOS3cJpi3ZxggZnf3hlbKT1q4zauTUZ1JCZndbekNEuNcSL38IwufQUcHL?=
 =?us-ascii?Q?HpYYzQRkunA/YKCJb5kekwx8Q41hQa20RRYoLC4dggspXvh4KIHtWFv4RE9g?=
 =?us-ascii?Q?2N9jVJAjsblCqxMDbq+LsJBZAbfSABGWHKKUBlOz6canEh2BYmWEW8y48d8L?=
 =?us-ascii?Q?WyPDKMAdKbNVCswQ71O7wsA4ild69bAplujbmH7EsSV03RIzJjAotcVPzJGg?=
 =?us-ascii?Q?/3B/bGhf2nyu+BPRUSuzAaHQOe+rirwdTibaH2dNXq0zDH4Qdk8Xm7EQffZb?=
 =?us-ascii?Q?Heignf8QrdjMnPf2APfU4eTH1R7vqPJAPSThvALkMkbizIf3K2/rWRXn0IzA?=
 =?us-ascii?Q?KnL4Es1Et1f9l8lZfSzRlwM2/ST4Fq17bE5s9GlW2LbZin8i5J88vPpb2zNM?=
 =?us-ascii?Q?PvAjzer72/nO7XUWjGvvqGKevmOFBDNrLuXoviMA8cMVEWftEZGAkIEShV5v?=
 =?us-ascii?Q?Hs5Erk2IIV9PcCN9Sf5R2U010N8+6jKYQp4A04NZu4G3Fey2UrPA+2Z3tmpM?=
 =?us-ascii?Q?cvzSHOH4YQAqCRigDQj/qe1R9cnMMMykO5Q57yEI5mVcsvP3Vqk3KDm7a18J?=
 =?us-ascii?Q?OohtGDMrCUKKdRN8ybVaVxoCWpF+C9d+FCilsg5Y+yyDDd2iTnB6Sk3Kma3j?=
 =?us-ascii?Q?w2Ar6RKZ0kOt/iDYcuxotk/xZPjvcojbEXlkp5QxGNmQDZxo9rPlmAQFs4qL?=
 =?us-ascii?Q?Y+US0cfMVYiHTsKQDWqRBaTtyiodHaV1KAZL+zfc4+nce32ttkE50Qcq3xyi?=
 =?us-ascii?Q?b3tQNRvxpaUJUWYrcQYw7XkpxSpYhDcEKBPxwBSEb7JgBEfBupZF05ViWDzz?=
 =?us-ascii?Q?qqfHIRkXfQQN37AyV2rRG9Nk9X4HGqXeYg3MfJOwfQFDF5brBnX7vkkDKZMM?=
 =?us-ascii?Q?RMeJCy4o6VxXCME2i4fuYcjAlwcX4XyAbBWSCqD9bxTcNcieW3lZG6EG6Xwc?=
 =?us-ascii?Q?0pg9+doffUFZ5YUEqPbRUJrahLzoDITtuhyq1uaJKR0O1vUQU0lL6cW0szTl?=
 =?us-ascii?Q?GxRIkJSJ0x3C7uFwgvQ20xAKjUPKraoamCZ6vwdR4mBvJVaPNVhVGlUGWHZm?=
 =?us-ascii?Q?GaJ/i8CaJAb3rbUph6K6h+vDs51UwAuCcY+UTdW9xjZSH0nuQuHCrUTxmiC5?=
 =?us-ascii?Q?7A92Ay7q+HN0VgbzHVTDOk+i1/1UVW7qqlGfU3Y1tThSMDGs9m55Z1GQ59lN?=
 =?us-ascii?Q?C0pHocMNTUPQlvJ1fzNneBYcVfXgG3vqLNB3scAULooem5wQlZ+TgyEJy8S+?=
 =?us-ascii?Q?1g9S+M4C3WhX7m/JI6o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rSSEZZQVisiyvWuRr5QxnK9v8AQBfJakegJ7Y+UzjQ5lDBC10q1nTAKK/ubz?=
 =?us-ascii?Q?sr5JRLGBQnbvjbJ6qjnUSJ1QYZ47B6SlFPeighzR7iqGN49mdAIlvkqQk/Yd?=
 =?us-ascii?Q?880z4m20y0dCURNngIar2T7p9bVeGioHhO3G2DZHsnPxlKVM3uPaLeGYrzRB?=
 =?us-ascii?Q?06N0Yw/JegjMYbakclzf4ff0bv2oxAcvfyEY7pRpXkC5TR4LMvJq1qT5IBS3?=
 =?us-ascii?Q?UTzD/W19pBupEl0zxCKD/KtdedCXnGSANozLPTukRbIJUDNEURGY4Ezzva2d?=
 =?us-ascii?Q?cMJ2zG7Rt1YaJH/JR1WpR8glOJ7ixnN0VUbsPoXA+DNqr+YWXW7KhOygphNY?=
 =?us-ascii?Q?ECUnVsH8RAc2WFDWBp1wjHmZf7lcnBTC6XRH5NJ3RYlYKUhN2CAIq0YpntZN?=
 =?us-ascii?Q?o99VpK/5S+2KYyO6sJHbaQ5MjPhH7APJLOBFaVle8erVEN7TNIMtbwWNaNgj?=
 =?us-ascii?Q?3uiQ1pks5ZmKj/+sPTMW9mvIGiX9dLgtYKGzoMXUo2TjmBaJFGTDmoQBpLrI?=
 =?us-ascii?Q?bwTLTYyOV70E1o10upSBF5CnNE0kUM3J31lu7P74LbeHgFXaCRzlmee6LS+Y?=
 =?us-ascii?Q?BS3VwQYiH40uTBvCvG6HctRJnFOrd/2UW0ZO5gPDFFQN9dD5tt1f3ODD0G2D?=
 =?us-ascii?Q?Zax3x8N1OefYoKvH4hdVDz3Ox6b04aU8esTZfq6X+Rn0R4lU1AYfsZNV0Zp3?=
 =?us-ascii?Q?FeB+k2sU51mvFF7HCRb9yjtjwu2fv4gJ1YYI9XlLvkY2bAjchdo5tcRW0ocJ?=
 =?us-ascii?Q?xDiCBk9BfRDao6ZI8cqsGnfsSVxj8Hjx/2jr8h+d1/bm827FWd+02rWOGQH3?=
 =?us-ascii?Q?EwDjyrqw5aV0CKNPlJhZWluCePuaXRLEiYDQNrH+u+SIZ6xN+HVUjDhiVDc9?=
 =?us-ascii?Q?Gndj4rWXoJdkzJs3IQHtQw7scCtxSX3YCalwXb0iYHeB/NbhsGVGYgDbV4WJ?=
 =?us-ascii?Q?6sPvJ5rSrEirjGD5eEH7y25K0ZtjV3FhdDubKZBe1H/fLChqOZD8PAFUe9ML?=
 =?us-ascii?Q?IYYQ1ozhAPxIYlStQCn780erEmPH5ogmwjldLG1hqRMiR9hpTfpE1npc68fZ?=
 =?us-ascii?Q?Sv8Wa/g+IeTcGB4+Li8xbPHGZvrQzWPONylniApvuxKd9nB8/KwZ6RGF6nSA?=
 =?us-ascii?Q?TT5Xq568gtvuPSoR2VEXcB2k63zzvmx+LPJgxcwQR4w4BF2ai9sOGXo8LMCs?=
 =?us-ascii?Q?DUaQy7qJd22awczozU1mbPFbcnbGkUW7MGrZuGAr9xQCR9TGj+cGXJVexary?=
 =?us-ascii?Q?Uozv+wOgapCdIDN3n/cdxVf+vwYfU9RRcjoodMOWfOstIwDJE1KvvvFaSkWc?=
 =?us-ascii?Q?ypqO8X/lpQQq1BbSu63quSr54Q6ADF9++UTku6+pkX+kRsPEJ19LV14h+Hu0?=
 =?us-ascii?Q?s43UKYq3nrSZCb9dKGwMkdiEQY4oA/5lRTZLModouNRxUhnoNOmv1hlWJmaE?=
 =?us-ascii?Q?6iu7jn/H7HOWdVReyWOgG6UDicYIOGacUayDTb7Hwj9c5qEXwaJWR0H6zWEL?=
 =?us-ascii?Q?PKMtOMfv15UGPVUHUPR+2yFEAI7Xq4glDpDcgMNSoHQ/40Fu9k0LzKoB4L87?=
 =?us-ascii?Q?ctt3S5qiVvPlhndYbIVahJlPV1USdWwy/oH2PBcJfBZtisyIY9h2YQbD/6rn?=
 =?us-ascii?Q?gsB8AnWt2sJpEyVk3T3jfDqnTmICJhI8zcgFdRQlO1+P8YRfEBy8YR/pvBoU?=
 =?us-ascii?Q?hJT1rKV+VZefqWiaPUcisM6ARKO39a0c+oIJ6k1tfx4dmTNi/DZwBpgFFQVv?=
 =?us-ascii?Q?l79V6wkJAzQxlfRjBmW9oNMu372gUGFQi+fHA2Oa/vsO3lxMTow+?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f0b571a-c403-4b1d-8d2b-08de5d55016d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 03:34:41.1772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kZQyKBOz/FUj5pB+RzguoE7QVCWeAWue65/4GaEKuUDbjocu4vYzpMlnI7r+FmHhTZ2iTYjt0t6jyWL8OrdZ7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5626
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8518-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,gmail.com,google.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,valinux.co.jp:dkim,valinux.co.jp:mid]
X-Rspamd-Queue-Id: F12AA8F9A9
X-Rspamd-Action: no action

Remote DMA users may need to map or otherwise correlate DMA resources on
a per-hardware-channel basis (e.g. DWC EP eDMA linked-list windows).
However, struct dma_chan does not expose a provider-defined hardware
channel identifier.

Add an optional dma_slave_caps.hw_id field to allow DMA engine drivers
to report a provider-specific hardware channel identifier to clients.
Initialize the field to -1 in dma_get_slave_caps() so drivers that do
not populate it continue to behave as before.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dmaengine.c   | 1 +
 include/linux/dmaengine.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index ca13cd39330b..b544eb99359d 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -603,6 +603,7 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
 	caps->cmd_pause = !!device->device_pause;
 	caps->cmd_resume = !!device->device_resume;
 	caps->cmd_terminate = !!device->device_terminate_all;
+	caps->hw_id = -1;
 
 	/*
 	 * DMA engine device might be configured with non-uniformly
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 99efe2b9b4ea..71bc2674567f 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -507,6 +507,7 @@ enum dma_residue_granularity {
  * @residue_granularity: granularity of the reported transfer residue
  * @descriptor_reuse: if a descriptor can be reused by client and
  * resubmitted multiple times
+ * @hw_id: provider-specific hardware channel identifier (-1 if unknown)
  */
 struct dma_slave_caps {
 	u32 src_addr_widths;
@@ -520,6 +521,7 @@ struct dma_slave_caps {
 	bool cmd_terminate;
 	enum dma_residue_granularity residue_granularity;
 	bool descriptor_reuse;
+	int hw_id;
 };
 
 static inline const char *dma_chan_name(struct dma_chan *chan)
-- 
2.51.0


