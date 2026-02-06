Return-Path: <dmaengine+bounces-8786-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOafMmUkhmlSKAQAu9opvQ
	(envelope-from <dmaengine+bounces-8786-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 18:27:01 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1BD100EC1
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 18:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A749E300A75E
	for <lists+dmaengine@lfdr.de>; Fri,  6 Feb 2026 17:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF4D3D4101;
	Fri,  6 Feb 2026 17:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="qCVDEkXj"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021088.outbound.protection.outlook.com [40.107.74.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5B73AEF33;
	Fri,  6 Feb 2026 17:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770398818; cv=fail; b=SOLtKAoDkxmHHWhs5DIqylfAuKYVVK3cebXrIZjt1NYWpBD6pt9S0p73SVQcjlynoatT+Kr81IQqUdLRaocPDA4XpAtSjmdfwKcXzJ7JggPdNUDScAfss/duY3Q8mvO8za03dBSWSWZE16S/5xF/w63+6SiDMjEyxiTib2knF2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770398818; c=relaxed/simple;
	bh=uW6z8iDWnzn/cvmgQtkuFjAus4CgkbaZWZHXDPpQGI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LWrr/mFj+EnLRjf80NnDGkytxYav0Pj9m73HRDdANq1M4j2PbBFo9HLdoCHbHS1U73VS+gsFEFfzn28ZWbVB12fO7KNZwbeD0mVsjHV7KzpNctLl7blHiHUFX36L08X3a1kvB5JLNBVEitEIof212EJloAmbWFG4BF5lOP1IeJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=qCVDEkXj; arc=fail smtp.client-ip=40.107.74.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=svPTtG/ShxWsGBb5AymOvI4tYA92fvrRqMrCI/Yhc6tI4Td0X992r+pHT3giI476YLSJbsqbG3uuzq7j2G1VdWGXwdg/3UEWRV835Eb9NgWCod2CLAhXMi62OhhJCef2S0BknyaigW43nC0Hn5NDwuCgDXAEak7C9UJHr8y1owZjjPQtcQ+mlxmiwwYGNHCSr1m8MRC1OdAeA6AKH8BAV2fytoYm48rEdeOPOmPZswAyxEh+DxKCKvNIncCE1pI6peeyoPfuV2wGYd9wbejkeJ++VQr94Ft/yZL5pxmYrZJTPIemoZTGL1R6BWKUpE9TLw3zyfaG40ONWKpTi2h+pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWVjo7akb72UIMUk35QMeuQR4dJioA4EPAXUmizM8Uc=;
 b=rBgo+InAFxa97l0RCN1mxIuSeWAgHFDz7G89jVdZoLdCosqEuUdZBMD5fW1K+ZLTsQv4gNJZLxbIrlBrZBRV4d5U2F3XbNeleJr6DxvuWYx5V0wwu4W5/wnNQCvlLCTiUuUc4+uJ3qxm6x54Wjg8HEbjB5e6MGupedKUH7iddZSvHDi8QUHV+Wjj9ALIn6Oq02mjKOn3A/wV7AHs47OyQaL+vpTa+JXl0q9rJjQ85K+Tw4LRK57ITQ9relt3Uw/SlaWhK3Or+4yW50xHy//ICpSAXurV2WEVApsHYGchig1B+6JB/NeSOhYznx9xLAIXAj1FqGNVRJGaT0YQcdee/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWVjo7akb72UIMUk35QMeuQR4dJioA4EPAXUmizM8Uc=;
 b=qCVDEkXjgU6aPeUtWwDx1ubRQx8Q1MPWp2UHkpESM39k5HBCgP5n6z+wVZkkVW0eCvQhHJurAxtcDz4BDeXINDi1rl7/fBr2+SA6rWO55OClYUNBsdZypLbHC1g7KP83RjWBvMqc3BxPpx38uNPOgvQjeM8+h844S2TXsmlKvAA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB5571.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1f1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 17:26:55 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.010; Fri, 6 Feb 2026
 17:26:55 +0000
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
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/9] dmaengine: dw-edma: Deassert emulated interrupts in the IRQ handler
Date: Sat,  7 Feb 2026 02:26:39 +0900
Message-ID: <20260206172646.1556847-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260206172646.1556847-1-den@valinux.co.jp>
References: <20260206172646.1556847-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0361.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB5571:EE_
X-MS-Office365-Filtering-Correlation-Id: ee379e19-f073-48c6-de2e-08de65a4ecb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mc1VOD420UkIrUZ4jlDI9LTHjjA8TIp/bdIYh96Uxirit0lvoFhv21xn40/J?=
 =?us-ascii?Q?5KevjejllikRSkK0uNZ5Qetq+pRSAHknaC/5Ju7NpQFoWbVGHQ/rNZWroT4w?=
 =?us-ascii?Q?lf4HUNdpuUgl6md4mm83hf/PfRymUqF4so8jTXXZJUDMUmE/GYBh4cGXydwi?=
 =?us-ascii?Q?zgnUBM/datb26+WnCvyyawe6rrCPwpxdKEipM9jhQqa7Ew0Bqxi8hkr6Ccdg?=
 =?us-ascii?Q?Y4fisScH5QI1TXxN7SUDP8Gq9PLDScL28E1/Bz8wSwLU1HsAyS2IJ/9wp+j2?=
 =?us-ascii?Q?PoI8wGLeT68qh38sZLC8AL3UNL3V9EI0RD5lIMc5c2ipsIuMTmCm3qqA8oGf?=
 =?us-ascii?Q?q6ghqKtxCosEFPEM2AxqXZ4L54AiHckL8J8BcKm74akZLXeR4jdqXmfEBXXr?=
 =?us-ascii?Q?gFEmUBN9P8ThkPOaR0LNkj6gqFQUfeCWp3hDx1wMd7qJ+YTsaIsZ3RgR6BkS?=
 =?us-ascii?Q?83b190U92be39NndDLdMbCGscnpqlokGzzJZxuWwBKev0Z0H3YlGxILdxwKF?=
 =?us-ascii?Q?o9iRq3rSD+PYQukQixF8bcaj2PUYiDYPSIDLqe5DTR6Ijj5n8Qy3SHj8mr9G?=
 =?us-ascii?Q?k0/xatkF8ow6DMPaB83CI4OKMkcLRABP+kOm8GAFTb2XISeD+mIAy4+i4dEq?=
 =?us-ascii?Q?fvXQublB1Z0D18E0XFj2M264s8oI71USRHUHtocDiCET0Vi9kX3EkBBjJlei?=
 =?us-ascii?Q?czmw4EyQIds0qBsEfRj8jBpGT3BrNeGge/JHRtAb+3BpT11rZE58Co4qFWiY?=
 =?us-ascii?Q?P7lz/sjRq0xJyZusZUaFoXsLmWoLsuwlPhuVTmD8zMWCV04BKznT0ZgOAkba?=
 =?us-ascii?Q?5ohgix23H7bwl1Sr0/evPDkZXnEdJRuTFD0yOGSndN5d02jimBybsdPhlLt/?=
 =?us-ascii?Q?fA1p256osenJy3b4ENl1+cmKG9zxC+3HUzQU1xjM4rD2DXXuOum64+nRuDug?=
 =?us-ascii?Q?ztrgzX8w8C937gPvCXq/KrFnaZlpLpqK44ugvN5X9qyk/uLWybo9cRs9Ka6O?=
 =?us-ascii?Q?/5LwLqM1lMF/ZiTZ8I+VVhqvUEIZz3LwBCeekq7drghUh79Bno2cDyRTBHDq?=
 =?us-ascii?Q?ahhwUneihy6/ACopOmkp8o+kUVM8KLXOITF6PwJR27GvXbdd9h9uRPABCFuj?=
 =?us-ascii?Q?P248l9DfAcXyx6RzgcCZTustMn/fCBIhukf33MJE2LmAea5zSe1Zv2AYDCdY?=
 =?us-ascii?Q?ny2u3scO6SwxKHHKTWdAb21ZZasjaWyr2h5znY5kmd7tPC9/aKk8CAYE4svH?=
 =?us-ascii?Q?rflYM27j4bbtJPQ74eGgGTkRAVg8Lrn2ftWkPU9QHeySvJpvzj+VQzm20vNE?=
 =?us-ascii?Q?EiRVyEzIJe3Osi4Yq1G2Ix6azabiNcrURnA1weq/R3o8m1eDK8clBIq8LaVJ?=
 =?us-ascii?Q?pQgN2Vw3QRoG4AAIlcjwdT4kAId/IYrtTVqfuQ79VGtwi/mZfJ6v9qrfBNEK?=
 =?us-ascii?Q?1NaEpgc/5gY/sJyxc5xhBBiSLxDWyUkGfPq4P6XsFSZy9Nya3nNoAZSV7VG5?=
 =?us-ascii?Q?19qd2humQA+8TMYdfzmjaLxUcRl9/MUHaF49NkE33M7lmi7MphRKFM1dVKsB?=
 =?us-ascii?Q?WDun4vRs4R7UoNOs8Tc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o09R/19TXbzqLRvkFsLY12y+rnmNWmG3e9bnHrp8OAQpnMhVM8ru8fo2m9lN?=
 =?us-ascii?Q?mBnGuncoQDe/UmM7ip1rWoYDpkglEhuP/FkKY88YGDY8Rf/CKTP5gHmceJPG?=
 =?us-ascii?Q?+JyZBI1R1lpTrCdFMpM3NfW9mUXIqS3KmKZHoysrd/jWRDXP9rbZ+bk86s3U?=
 =?us-ascii?Q?zfHh4tzmdiel/A33K31mv7DgTfYf10bLOoszr1WCwCuzPji+nsOIHnwAF52y?=
 =?us-ascii?Q?rDwfHKXV2t/FQKt5Ya2uggnw57TnHRWr+cbF7iHgwEURY4nUO1Ck+9pJZCu7?=
 =?us-ascii?Q?HwNnwSWRTBzWizPBQPbQhVo8VwDXsSYPpHml7Gwf5Twb+Yn74Q/qGEYvCrQA?=
 =?us-ascii?Q?2VHl25QyLcs4NqxcG7XBp6XFhZaJviLmXW4IjbLLJbljsVATpQN+Qf3RCM1f?=
 =?us-ascii?Q?Adw+IACBEHiDouivGtI+0SKcYNosAo1/H2DTAPUajjQ+gNMkkxnFc47YYarl?=
 =?us-ascii?Q?KrLe6eu1NcCpXdqPCc8RvTxLYsctE4VuaJDgMTTGPTkFTMsYmVIYruHUYP/l?=
 =?us-ascii?Q?9/X0jJR2XtebxJW8IpLLA1N3x7EmUSFE3lo20tNW/fB9xXNEWuySI4uqM0jq?=
 =?us-ascii?Q?N9Xc6h4TMqHDuf+P0dGekFW/4ajoE1tmkCBnB1O6/5lBS5sqmCPaaB295X1f?=
 =?us-ascii?Q?1Cbu7sQXevM7LJBwaW+ziCy6V6e7H56rRXRQ8mK68vZxmv+9JK6X8Baqn2AQ?=
 =?us-ascii?Q?G6swkKcsXJ+vFY5u32SFgNmJicJHGAXZjt43qZHQj313IAS5pi5f9f4yBMkK?=
 =?us-ascii?Q?EcSd3mYc7rVFdf0AUKp5VpqjVqJUpGo0LGHsx7ezfoBRTxqSd1uBA3TFq0sx?=
 =?us-ascii?Q?H9ATOGWfFlGtLZkwbKnBXCfIr3BzkAUE8zlamVBZLWmYojaE3iz3qGCVXory?=
 =?us-ascii?Q?5QGQy7jC1CXKLu5IjXeZ6DuSJLo+SSPkeUStwopJmNJ8KSfsoWw6x3tG85r6?=
 =?us-ascii?Q?Ts5jQLNWrjmAJaYMcwzBiPRNYD00Iv89rCiR4zDv9w5xWrC4bjuKFcsuDOGC?=
 =?us-ascii?Q?fuVUHYohi2UwwVqFLyaq8/5QHhDAdDCq2ipaCvs5FqBQzjjf2z9uMRN7Fkbf?=
 =?us-ascii?Q?cmdC5IX4eNnJaLe0woMzTsDOgBi2TSRhL7TXLcN7YqxZrOVfmscR2civXwVa?=
 =?us-ascii?Q?eyHVsmERqU2U0h3OuZf/J1ttC522iSvGlFGvQi4t0x96Ohsg7CkGJekBYehk?=
 =?us-ascii?Q?6d0iRrZa42wCsan6Tc30OE75gNOWvgLm+/oje8JYVq0GbhcVdWycpr1Dxl9p?=
 =?us-ascii?Q?MH9mwzN0ziwT8h5DQJ+hwGK4prW7Ipk9w5Vds6sgo3RR4ngNB8h+sYJff5mn?=
 =?us-ascii?Q?6JigOWMC6NnND3/b5I0u2CK/8ALvwzGnp4ntxjbYYmOTJxts4ZexgargPgNt?=
 =?us-ascii?Q?TISvqz9Blxx70WPGbTWGcUNap+JbycJFzJjRzSs39c+9wqafq5TcnV0fKVF6?=
 =?us-ascii?Q?ZdcY62bAgVRrK9uXBzKn0QxJ7NPGwVRoti50BB+sQlkLq6XLCdAKXgPPCMEG?=
 =?us-ascii?Q?HcZlOG2pVHXCSTp2X0RGT+kqMbJ4iSJs/P/j16sLDoSgnB54qdHBvdITyNek?=
 =?us-ascii?Q?g/XnkNR06+7/9A/qTB2oOUrRyNTzwbVv+Vjbhnv9wzVs1RdK7v1IY8MMUGRb?=
 =?us-ascii?Q?dPYBUwZdmvTdERzWyUSM+XwQurwZKq4QZsfjX4rE7pezP3roj4QETGRobAo8?=
 =?us-ascii?Q?Ymf0+HvCsWzKi94+NN2mvdlZ1vva1R5WNYJ/HA9qPm2PLbc27wonW6d0KZhl?=
 =?us-ascii?Q?+45rHZZ99BPUDiaPSxCbNR4Yt6uMhr4b4BZpO+6zsVKgKloFJZMN?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ee379e19-f073-48c6-de2e-08de65a4ecb2
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 17:26:55.3768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NQL/7ZyLfD7MoyaDvnQLKlTuHhVM7Hci9df4YIMfEFj6rU9aPmQwHyG/bSH6ShX+stLRf30hSdqgHrLf3nf+9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB5571
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,gmail.com,google.com];
	TAGGED_FROM(0.00)[bounces-8786-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: EF1BD100EC1
X-Rspamd-Action: no action

Some DesignWare eDMA instances support "interrupt emulation", where a
software write can assert the IRQ line without setting the normal
DONE/ABORT status bits.

With a shared IRQ handler the driver cannot reliably distinguish an
emulated interrupt from a real one by only looking at DONE/ABORT status
bits. Leaving the emulated IRQ asserted may leave a level-triggered IRQ
line permanently asserted.

Add a core callback, .ack_selfirq(), to perform the core-specific
deassert sequence and call it from the read/write/common IRQ handlers.
Note that previously a direct software write could assert the emulated
IRQ without DMA activity, leading to the interrupt never getting
deasserted. This patch resolves it.

For v0, a zero write to INT_CLEAR deasserts the emulated IRQ and is a
no-op for real interrupts. HDMA is not tested or verified and is
therefore unsupported for now.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c    | 48 ++++++++++++++++++++++++---
 drivers/dma/dw-edma/dw-edma-core.h    | 11 ++++++
 drivers/dma/dw-edma/dw-edma-v0-core.c | 11 ++++++
 3 files changed, 65 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 0c3461f9174a..dd01a9aa8ad8 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -699,7 +699,24 @@ static void dw_edma_abort_interrupt(struct dw_edma_chan *chan)
 	chan->status = EDMA_ST_IDLE;
 }
 
-static inline irqreturn_t dw_edma_interrupt_write(int irq, void *data)
+static inline irqreturn_t dw_edma_interrupt_emulated(void *data)
+{
+	struct dw_edma_irq *dw_irq = data;
+	struct dw_edma *dw = dw_irq->dw;
+
+	/*
+	 * Interrupt emulation may assert the IRQ line without updating the
+	 * normal DONE/ABORT status bits. With a shared IRQ handler we
+	 * cannot reliably detect such events by status registers alone, so
+	 * always perform the core-specific deassert sequence.
+	 */
+	if (dw_edma_core_ack_selfirq(dw))
+		return IRQ_NONE;
+
+	return IRQ_HANDLED;
+}
+
+static inline irqreturn_t dw_edma_interrupt_write_inner(int irq, void *data)
 {
 	struct dw_edma_irq *dw_irq = data;
 
@@ -708,7 +725,7 @@ static inline irqreturn_t dw_edma_interrupt_write(int irq, void *data)
 				       dw_edma_abort_interrupt);
 }
 
-static inline irqreturn_t dw_edma_interrupt_read(int irq, void *data)
+static inline irqreturn_t dw_edma_interrupt_read_inner(int irq, void *data)
 {
 	struct dw_edma_irq *dw_irq = data;
 
@@ -717,12 +734,33 @@ static inline irqreturn_t dw_edma_interrupt_read(int irq, void *data)
 				       dw_edma_abort_interrupt);
 }
 
-static irqreturn_t dw_edma_interrupt_common(int irq, void *data)
+static inline irqreturn_t dw_edma_interrupt_write(int irq, void *data)
+{
+	irqreturn_t ret = IRQ_NONE;
+
+	ret |= dw_edma_interrupt_write_inner(irq, data);
+	ret |= dw_edma_interrupt_emulated(data);
+
+	return ret;
+}
+
+static inline irqreturn_t dw_edma_interrupt_read(int irq, void *data)
+{
+	irqreturn_t ret = IRQ_NONE;
+
+	ret |= dw_edma_interrupt_read_inner(irq, data);
+	ret |= dw_edma_interrupt_emulated(data);
+
+	return ret;
+}
+
+static inline irqreturn_t dw_edma_interrupt_common(int irq, void *data)
 {
 	irqreturn_t ret = IRQ_NONE;
 
-	ret |= dw_edma_interrupt_write(irq, data);
-	ret |= dw_edma_interrupt_read(irq, data);
+	ret |= dw_edma_interrupt_write_inner(irq, data);
+	ret |= dw_edma_interrupt_read_inner(irq, data);
+	ret |= dw_edma_interrupt_emulated(data);
 
 	return ret;
 }
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 0608b9044a08..abc97e375484 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -128,6 +128,7 @@ struct dw_edma_core_ops {
 	void (*start)(struct dw_edma_chunk *chunk, bool first);
 	void (*ch_config)(struct dw_edma_chan *chan);
 	void (*debugfs_on)(struct dw_edma *dw);
+	void (*ack_selfirq)(struct dw_edma *dw);
 };
 
 struct dw_edma_sg {
@@ -208,6 +209,16 @@ void dw_edma_core_debugfs_on(struct dw_edma *dw)
 	dw->core->debugfs_on(dw);
 }
 
+static inline
+int dw_edma_core_ack_selfirq(struct dw_edma *dw)
+{
+	if (!dw->core->ack_selfirq)
+		return -EOPNOTSUPP;
+
+	dw->core->ack_selfirq(dw);
+	return 0;
+}
+
 static inline
 bool dw_edma_core_ch_ignore_irq(struct dw_edma_chan *chan)
 {
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index a0441e8aa3b3..68e0d088570d 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -519,6 +519,16 @@ static void dw_edma_v0_core_debugfs_on(struct dw_edma *dw)
 	dw_edma_v0_debugfs_on(dw);
 }
 
+static void dw_edma_v0_core_ack_selfirq(struct dw_edma *dw)
+{
+	/*
+	 * Interrupt emulation may assert the IRQ without setting
+	 * DONE/ABORT status bits. A zero write to INT_CLEAR deasserts the
+	 * emulated IRQ, while being a no-op for real interrupts.
+	 */
+	SET_BOTH_32(dw, int_clear, 0);
+}
+
 static const struct dw_edma_core_ops dw_edma_v0_core = {
 	.off = dw_edma_v0_core_off,
 	.ch_count = dw_edma_v0_core_ch_count,
@@ -527,6 +537,7 @@ static const struct dw_edma_core_ops dw_edma_v0_core = {
 	.start = dw_edma_v0_core_start,
 	.ch_config = dw_edma_v0_core_ch_config,
 	.debugfs_on = dw_edma_v0_core_debugfs_on,
+	.ack_selfirq = dw_edma_v0_core_ack_selfirq,
 };
 
 void dw_edma_v0_core_register(struct dw_edma *dw)
-- 
2.51.0


