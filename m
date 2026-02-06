Return-Path: <dmaengine+bounces-8793-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNFBB/ckhmlSKAQAu9opvQ
	(envelope-from <dmaengine+bounces-8793-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 18:29:27 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 705D410100B
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 18:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DEC7305596A
	for <lists+dmaengine@lfdr.de>; Fri,  6 Feb 2026 17:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F27E3DA7C7;
	Fri,  6 Feb 2026 17:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="i8nSSTTa"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021088.outbound.protection.outlook.com [40.107.74.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF78A423A63;
	Fri,  6 Feb 2026 17:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770398822; cv=fail; b=iLAOXZ+S/EZP4RbtA8Orh/9tDNruDcaaxya4ub27uGsKAYelcGEyyhxuWpoE/TQgecyDug36ZKHPnBseHgFq1+IkcpsDzYk0RmHny906RL9HjGAAn3ZmRt7rkZlaqcXbwLFm5yEgAOGP1pOsdrIFHAY5MV3yP7sCWhMJfvCfAH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770398822; c=relaxed/simple;
	bh=CL5jsTp7lrb2+wcday+T4gsJMpu+/RXeRgEZxu20qfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WJQ9hZOxnMIwyZAHe0ohGAP1nvE6I0m3IoiN2xP5cscuByYi6+bQmWifZrmPm06mH/JvLL2NgYKxV3IrZUiIgnf66ZZMkzpv9tvoWQyuHb7nLEOZoA7toYAtPF2ZoPUaui3iI4l6AwFR5eO/AA+5bsOQv8rDsOWhhV56DQIarnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=i8nSSTTa; arc=fail smtp.client-ip=40.107.74.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C0Gd6Ug/GdZNHC0oKAT6lBzI+841jAvPmNLJVm8S78h/zueoZclyuxFm3+nyLM9KDKSJU1HjItXKQj8pjqjpfwkYLFXJrbyDnboHy/fhnNa6LQU2a25tSoqKL995QKWRUJKiHsXMq5XhhbbLjkxFLTvWSN6kHpjdB8xUi0rnbWyKqH8YQpLhiqyIs2UsgtZIFSBV4n2+0iIoDh36cfqL4cXw2Z//+Hs2/0jd+0QThVxcDb+7mVDDP9p2Si0BhPcB2Iv15aW77AQCgZZsQ6zEuDVqTZP3j4TBZvzBT7lR69N8EGwTKY6imQJcgY6Fk68t/oW5SGpyruh4JgvBZIfddA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNsPpLeWwvi+3IPaU5C8kjjJwYYVszKY1ZV7br5WOV4=;
 b=VGGn/lJMfZbckrDPoOazP1tRs3j3k9h0UXpANqZLrLMYqhXjH5pnSYhIuqyNiW+HrIhCyz63jaFPrbnc7ELXDgQGlo8mCKqoWhzUEvHXwi+PJCfC8mzUplgUGfxN6Nf4DEyRp2iXsIBPnfm1CH/KvIQNTXUYfauwS8VHgy0GP9k/k6GCJ6oDcDp58iHFFdZoiUlBr977ziiWVcSTGqq2t9vCUaIztzGAleXtK+cBNHTP8K6LiBk2Dv62A8Oe26RE2zxVQzSabaqQrVjOttAnUC6cGoGNj598KjRulfx+old2FmkFyVHuBNSBaTikyME0lGbxbzIDPzGMCq9kRHMTrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNsPpLeWwvi+3IPaU5C8kjjJwYYVszKY1ZV7br5WOV4=;
 b=i8nSSTTaB0gajjC5urw1Di0pdnzTYVHU+SvnEdF7jSTH2yLk2qjn+MNZyG2cMVxrcaKSeuRBLrNsgfc+e/1J81MPB6RhxNg8KwG2nhwK8mogtPw58fbL2gCChaaEAOIeZLXv1OYSmfXHACGHagQePa7um08d/LHY1+MlJ+3kDyY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB5571.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1f1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 17:26:59 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.010; Fri, 6 Feb 2026
 17:26:59 +0000
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
Subject: [PATCH v4 7/9] PCI: endpoint: pci-epf-test: Add embedded doorbell variant
Date: Sat,  7 Feb 2026 02:26:44 +0900
Message-ID: <20260206172646.1556847-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260206172646.1556847-1-den@valinux.co.jp>
References: <20260206172646.1556847-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0027.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB5571:EE_
X-MS-Office365-Filtering-Correlation-Id: 11d81071-2d22-4f69-4b6a-08de65a4eee2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ip2N8HkSFfCL6PiaKlpiO8HleiXTlI6cO+hwVzidvz5uvjz75fQGUUgPdkXU?=
 =?us-ascii?Q?VEGMBVjIf43umM6UEcX5n7WijeRhJzU6T14kcu3fHYK0ZtD3dXmdIKqvaHD+?=
 =?us-ascii?Q?tpIi7NrmDwJa118icoApdU3uTOusXNH/VAGXv0mRM9Ll9dKmm1bkLbO8v39h?=
 =?us-ascii?Q?4ZjcffmfJaHy3D20nJgm5TKRFDwqvG7yTRO4wJC9iw9bNtV+suw73YFz6IXc?=
 =?us-ascii?Q?iVnc81f/5iyJZRWXtUW0m6W2yj+Xr2EE4EU04zuKHTwsE9e7gIXM7SAnlh9R?=
 =?us-ascii?Q?6zu7+YTRqAa02mze6SnFnHJkSos2U9Msgt48LtjrMjKIAwqqBmESZI2pnOL1?=
 =?us-ascii?Q?+B+xi5h1upLSYdvp/T41pbjaYCJtKimMSsNoMBLAPY074Ts7hLGoJNmdq2Gy?=
 =?us-ascii?Q?Mr7/evD6y2qtDb/76rLYZ7NT005AnsCeNhFkssFBvElM0hLzPSelUt4zRCTi?=
 =?us-ascii?Q?hc0kYMthwJmE9NOdeGjaffS5Tcz5tBOzaYqQvhy8nDswlKx/Mklec2lC5SGG?=
 =?us-ascii?Q?fLJTDvy8jj2ARnnIJhhCEh59stMQB0oFb5k9Qs3A4HB3mw+nF8CyO0fyDSXm?=
 =?us-ascii?Q?G63ojermxE8FPrbd5l9EKTMORDIITE/CHXpqEAFaGGx55njTAtNZzSkFWH2X?=
 =?us-ascii?Q?eS2W1yNdOU8JW0ibeUazAtvXpng47DT6V9hUxnLYKyA7HueFlGs0EFPs0elV?=
 =?us-ascii?Q?t81NRvD6UUl3GPUtobDzKsZJARbvKS0Q5/R7Jgkd6Bn7pEKeS921OofYw105?=
 =?us-ascii?Q?SDKAWbWcZyO+iEZZuzhl6B8/WLzoBfVo+evsFs0geRX+vGt8Uk2zBzteoCk+?=
 =?us-ascii?Q?Ft/X8VPNKW4L3N3PJ0QKNTjQMlE8gY0RW8ZTDMw2N2e12T0fFDm9zcc0ZoDb?=
 =?us-ascii?Q?Zg/2EpkXxsIJatdszEEuyZGO1QqLP2OaAuvPRGvH35MYzLbDPW1LE76fzDlJ?=
 =?us-ascii?Q?Z5CjWmyLwwOPP81cftyroiLq3XC2Lz/hEsmKdCtAY8Oavr21xAs9Z8vKZ44t?=
 =?us-ascii?Q?8av6KX/fRm9B7kMOnNcEGRQa6jYOFXpZDiBo81707HrgVDn/H22si1v6Qs8m?=
 =?us-ascii?Q?RpZ7ZK3/ML5fAvmOX3dPZcpaivsM3p2bFS7HZURhqNXT46OcYT3ygf5Uvmew?=
 =?us-ascii?Q?3Sr8D8/Os4EgRgxXxudd6L9SFv1/vuP/l9LY/wW0+U5lgYF4RUDW8J0Nfech?=
 =?us-ascii?Q?I0FtWXeffD1eGPDCE83lADkfdoaY4IJ/Fpky726dxlZ9Az2qnVv/6z3UdafL?=
 =?us-ascii?Q?zGom6A/um88Oy6k8lV5x3NafRIwL8SXWIWyLWSPZ750zRy1B52XBp4ACQzIo?=
 =?us-ascii?Q?A+DXUK6dMkSQAAqdhb5ZvXgTZyH9YpFF1Imt2ayRBnXYwhb0gKWr4kQJ9wu7?=
 =?us-ascii?Q?RHRprv3MhOq5fPdDin42fxNELPQxrv/BD0R8vK+hAkPtcyWbSCSeJ1hfoLGd?=
 =?us-ascii?Q?5ZWA2LyGSOw+AioLl//0y73psVxpNc+aOsaNDTHtPwfytVEUqizocQCdYZaY?=
 =?us-ascii?Q?qHYM679RYbhnrSyXFhPRAKVk5LXGc72hkchsvy0/TvUrHAfhr1hcwCFsTHdw?=
 =?us-ascii?Q?pyH/RraVpfMFT2EcG4E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tnmO41mZm/VOHBfbq4SIL+UI8AKkbBQh02A82QB3lNUpohBpencUv7pK94K6?=
 =?us-ascii?Q?DmWIvuQr7KcGjKGKaMzTWHWpHCYjVJur96EG56brAUxNIL2ChvKDXiHWHnWt?=
 =?us-ascii?Q?lv8umxJbYFvqsep+uCU4+9CH0wNp/0TLeY4dWWjEhAoRbEw2iU/92GcYqWrE?=
 =?us-ascii?Q?Gxk6Ao1Km1/OxLboc95y4fIybhTPjVOIFuHnizIIDN7GuTxjISMmjljHaI4p?=
 =?us-ascii?Q?DZxUXX4I6qhSKkJ85IsYdthJAnhMm3yf1y+gwSeiCcJxnr3U8UJDSDtdtVLj?=
 =?us-ascii?Q?Adwv2JPy1H72dZqN5wblWY6+VQQJu2EQ82qUT9eCC6AbES8ruHjHgopTNjSc?=
 =?us-ascii?Q?OTKdSVpwdHE7uNBjJP99XF+fCWTx59iwKSj65wjY0xT3ck6120Sbw3/4CHFZ?=
 =?us-ascii?Q?ITvDFV3KaNmO3Bl4zBS9CtKAl6oNQRdyv8xYKM+Thu6Jh7G/NFHxmd2AerKF?=
 =?us-ascii?Q?oNnBDcWA64kdWsui8DSupp4u90lHhNOoZQi24n9P3KdVK4AENlPT/729hQ5c?=
 =?us-ascii?Q?NWmjOiVWFrdCO1dw2jiJ8Y5+uba/OF61UWQquF11iLmHSC6jJIj0zA8FNglh?=
 =?us-ascii?Q?XEU+pOKQ9H9f9omnGemyo0g8Zx/pL+xc5hyZAxmp35t9+ir1cA2ImeWIt27y?=
 =?us-ascii?Q?smM+iH5y/zoY013chE/rT9kZZdysx+AvTei3j8XZO7JTYktjhts/H4iAr1E9?=
 =?us-ascii?Q?30EJwoTtZ8woHbo0L/7RMDCqdaLz9zn4voEGRpuEOBYEixvgPJupZdOhcBML?=
 =?us-ascii?Q?/pfolFtLq3+Aq1+g+15Rpp8yygHrPgmBqvJdkRxHluPZEfvaIFtOugdCJtwZ?=
 =?us-ascii?Q?1iJB2Ft1qc/1duPM/O0F0drycbsoXI4yNlE/QBDBo/Cv6b85Y41lcmtCn9RM?=
 =?us-ascii?Q?kRJxPs6YWv4CDe98RnKWEdlfbXysSoJPFq+G+hoSVANQygAL3gr/ykVH87m0?=
 =?us-ascii?Q?xk3ihtgAfdjjjdo6nOHqsVyfcHAbfeuuu7dxfnAVQyzwKviSeMjLvnJYhbIB?=
 =?us-ascii?Q?Z0RJuLrRtrhViO90NDqDAIukkaJmhNyyyFHlk9mpyUgTSWaqIssMPQkWYgxm?=
 =?us-ascii?Q?qwm1eZDJWNZy2pCWKacLzNHK/TXhh3X97h7vgiFOdam68cosMistkEDZ63ng?=
 =?us-ascii?Q?uUHYQkjJMt51uCTdaBffkwbxc+nbckiO4AkHrM1hstCO+Wn4knU9ARI+NZy4?=
 =?us-ascii?Q?QvBTPJOww2IrCOdvpLhV2OwfFvk6yUxHM+fGzIQsN1SSvEMVg2R30nj7Kd73?=
 =?us-ascii?Q?FVm1t5NwKbzWh9xyGJaoaptCFS2jh9iwPkucbeUgKmCvcuFp/28SteoKrpky?=
 =?us-ascii?Q?MDH8jiXOYvQ7o08oHVnMfM1Hxot8rR3EHX0uL4lQeDuOBNGfpHjTGZn0Vvar?=
 =?us-ascii?Q?0QM1ZnSRtS2aUydPBiLIENvxRE0toPxMmlq6NuE5mdMJ1W+s/aLCNAXtUDkZ?=
 =?us-ascii?Q?9Z8CRsn6ixJQKcZ3ChUoll1iN97HxdoRRZsVSPudzje72GIBiOPc8juSwmOU?=
 =?us-ascii?Q?tH35PsJuiz6b8MAPXg4ySmDDufqUvLSVEh3QiKrvE9n2YF0NCLMnitqEKwno?=
 =?us-ascii?Q?OMINJ8rBWbVSjoM1+SLDqAQMtmnKzvJteAs6x1Fljmk2c4PoPk821gpx1Jwt?=
 =?us-ascii?Q?myp7p5waVweuFaOnnU3j5mdoj3h3Jr9q9BubpUm2FL+nn2Pz/FpuPllLFRAh?=
 =?us-ascii?Q?TBu4rkObfsJjrhxTXZp2W4+5e2cVk8H2me6DCdrFiNXp7JklxA3jodcFtj0b?=
 =?us-ascii?Q?kXLoIu6rgmpZ3NkbDyaYFvrUaIB71ysqUEeLvlSo6d2T8kvcIiu7?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d81071-2d22-4f69-4b6a-08de65a4eee2
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 17:26:59.0451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pxtEH5TKjV14vfMHHL0Jw5SRdj/KO/ioStNQBX9k5NJuJxExrNRclbZtQBRdaW1RkUptyxmmFH5W+9MdGeE/HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB5571
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8793-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,gmail.com,google.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 705D410100B
X-Rspamd-Action: no action

Extend pci-epf-test with an "embedded doorbell" variant that does not
rely on the EPC doorbell/MSI mechanism.

When the host sets FLAG_DB_EMBEDDED, query EPC remote resources to
locate the embedded DMA MMIO window and a per-channel
interrupt-emulation doorbell register offset. Map the MMIO window into a
free BAR and return BAR+offset to the host as the doorbell target.

Handle the resulting shared IRQ by deferring completion signalling to a
work item, then update the test status and raise the completion IRQ back
to the host.

The existing MSI doorbell remains the default when FLAG_DB_EMBEDDED is
not set.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 193 +++++++++++++++++-
 1 file changed, 185 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 6952ee418622..5871da8cbddf 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -6,6 +6,7 @@
  * Author: Kishon Vijay Abraham I <kishon@ti.com>
  */
 
+#include <linux/bitops.h>
 #include <linux/crc32.h>
 #include <linux/delay.h>
 #include <linux/dmaengine.h>
@@ -56,6 +57,7 @@
 #define STATUS_BAR_SUBRANGE_CLEAR_FAIL		BIT(17)
 
 #define FLAG_USE_DMA			BIT(0)
+#define FLAG_DB_EMBEDDED		BIT(1)
 
 #define TIMER_RESOLUTION		1
 
@@ -69,6 +71,12 @@
 
 static struct workqueue_struct *kpcitest_workqueue;
 
+enum pci_epf_test_doorbell_variant {
+	PCI_EPF_TEST_DB_NONE = 0,
+	PCI_EPF_TEST_DB_MSI,
+	PCI_EPF_TEST_DB_EMBEDDED,
+};
+
 struct pci_epf_test {
 	void			*reg[PCI_STD_NUM_BARS];
 	struct pci_epf		*epf;
@@ -85,7 +93,11 @@ struct pci_epf_test {
 	bool			dma_supported;
 	bool			dma_private;
 	const struct pci_epc_features *epc_features;
+	enum pci_epf_test_doorbell_variant db_variant;
 	struct pci_epf_bar	db_bar;
+	int			db_irq;
+	unsigned long		db_irq_pending;
+	struct work_struct	db_work;
 	size_t			bar_size[PCI_STD_NUM_BARS];
 };
 
@@ -696,7 +708,7 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
 	}
 }
 
-static irqreturn_t pci_epf_test_doorbell_handler(int irq, void *data)
+static irqreturn_t pci_epf_test_doorbell_msi_handler(int irq, void *data)
 {
 	struct pci_epf_test *epf_test = data;
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
@@ -710,19 +722,58 @@ static irqreturn_t pci_epf_test_doorbell_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static void pci_epf_test_doorbell_embedded_work(struct work_struct *work)
+{
+	struct pci_epf_test *epf_test =
+		container_of(work, struct pci_epf_test, db_work);
+	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
+	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
+	u32 status = le32_to_cpu(reg->status);
+
+	status |= STATUS_DOORBELL_SUCCESS;
+	reg->status = cpu_to_le32(status);
+	pci_epf_test_raise_irq(epf_test, reg);
+
+	clear_bit(0, &epf_test->db_irq_pending);
+}
+
+static irqreturn_t pci_epf_test_doorbell_embedded_irq_handler(int irq, void *data)
+{
+	struct pci_epf_test *epf_test = data;
+
+	if (READ_ONCE(epf_test->db_variant) != PCI_EPF_TEST_DB_EMBEDDED)
+		return IRQ_NONE;
+
+	if (test_and_set_bit(0, &epf_test->db_irq_pending))
+		return IRQ_HANDLED;
+
+	queue_work(kpcitest_workqueue, &epf_test->db_work);
+	return IRQ_HANDLED;
+}
+
 static void pci_epf_test_doorbell_cleanup(struct pci_epf_test *epf_test)
 {
 	struct pci_epf_test_reg *reg = epf_test->reg[epf_test->test_reg_bar];
 	struct pci_epf *epf = epf_test->epf;
 
-	free_irq(epf->db_msg[0].virq, epf_test);
-	reg->doorbell_bar = cpu_to_le32(NO_BAR);
+	if (epf_test->db_irq) {
+		free_irq(epf_test->db_irq, epf_test);
+		epf_test->db_irq = 0;
+	}
+
+	if (epf_test->db_variant == PCI_EPF_TEST_DB_EMBEDDED) {
+		cancel_work_sync(&epf_test->db_work);
+		clear_bit(0, &epf_test->db_irq_pending);
+	} else if (epf_test->db_variant == PCI_EPF_TEST_DB_MSI) {
+		pci_epf_free_doorbell(epf);
+	}
 
-	pci_epf_free_doorbell(epf);
+	reg->doorbell_bar = cpu_to_le32(NO_BAR);
+	epf_test->db_variant = PCI_EPF_TEST_DB_NONE;
 }
 
-static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
-					 struct pci_epf_test_reg *reg)
+static void pci_epf_test_enable_doorbell_msi(struct pci_epf_test *epf_test,
+					     struct pci_epf_test_reg *reg)
 {
 	u32 status = le32_to_cpu(reg->status);
 	struct pci_epf *epf = epf_test->epf;
@@ -736,20 +787,23 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
 	if (ret)
 		goto set_status_err;
 
+	epf_test->db_variant = PCI_EPF_TEST_DB_MSI;
 	msg = &epf->db_msg[0].msg;
 	bar = pci_epc_get_next_free_bar(epf_test->epc_features, epf_test->test_reg_bar + 1);
 	if (bar < BAR_0)
 		goto err_doorbell_cleanup;
 
 	ret = request_threaded_irq(epf->db_msg[0].virq, NULL,
-				   pci_epf_test_doorbell_handler, IRQF_ONESHOT,
-				   "pci-ep-test-doorbell", epf_test);
+				   pci_epf_test_doorbell_msi_handler,
+				   IRQF_ONESHOT, "pci-ep-test-doorbell",
+				   epf_test);
 	if (ret) {
 		dev_err(&epf->dev,
 			"Failed to request doorbell IRQ: %d\n",
 			epf->db_msg[0].virq);
 		goto err_doorbell_cleanup;
 	}
+	epf_test->db_irq = epf->db_msg[0].virq;
 
 	reg->doorbell_data = cpu_to_le32(msg->data);
 	reg->doorbell_bar = cpu_to_le32(bar);
@@ -782,6 +836,125 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
 	reg->status = cpu_to_le32(status);
 }
 
+static void pci_epf_test_enable_doorbell_embedded(struct pci_epf_test *epf_test,
+						  struct pci_epf_test_reg *reg)
+{
+	struct pci_epc_remote_resource *dma_ctrl = NULL, *chan0 = NULL;
+	const char *irq_name = "pci-ep-test-doorbell-embedded";
+	u32 status = le32_to_cpu(reg->status);
+	struct pci_epf *epf = epf_test->epf;
+	struct pci_epc *epc = epf->epc;
+	struct device *dev = &epf->dev;
+	enum pci_barno bar;
+	size_t align_off;
+	unsigned int i;
+	int cnt, ret;
+	u32 db_off;
+
+	cnt = pci_epc_get_remote_resources(epc, epf->func_no, epf->vfunc_no,
+					   NULL, 0);
+	if (cnt <= 0) {
+		dev_err(dev, "No remote resources available for embedded doorbell\n");
+		goto set_status_err;
+	}
+
+	struct pci_epc_remote_resource *resources __free(kfree) =
+				kcalloc(cnt, sizeof(*resources), GFP_KERNEL);
+	if (!resources)
+		goto set_status_err;
+
+	ret = pci_epc_get_remote_resources(epc, epf->func_no, epf->vfunc_no,
+					   resources, cnt);
+	if (ret < 0) {
+		dev_err(dev, "Failed to get remote resources: %d\n", ret);
+		goto set_status_err;
+	}
+	cnt = ret;
+
+	for (i = 0; i < cnt; i++) {
+		if (resources[i].type == PCI_EPC_RR_DMA_CTRL_MMIO)
+			dma_ctrl = &resources[i];
+		else if (resources[i].type == PCI_EPC_RR_DMA_CHAN_DESC &&
+			 !chan0)
+			chan0 = &resources[i];
+	}
+
+	if (!dma_ctrl || !chan0) {
+		dev_err(dev, "Missing DMA ctrl MMIO or channel #0 info\n");
+		goto set_status_err;
+	}
+
+	bar = pci_epc_get_next_free_bar(epf_test->epc_features,
+					epf_test->test_reg_bar + 1);
+	if (bar < BAR_0) {
+		dev_err(dev, "No free BAR for embedded doorbell\n");
+		goto set_status_err;
+	}
+
+	ret = pci_epf_align_inbound_addr(epf, bar, dma_ctrl->phys_addr,
+					 &epf_test->db_bar.phys_addr,
+					 &align_off);
+	if (ret)
+		goto set_status_err;
+
+	db_off = chan0->u.dma_chan_desc.db_offset;
+	if (db_off >= dma_ctrl->size ||
+	    align_off + db_off >= epf->bar[bar].size) {
+		dev_err(dev, "BAR%d too small for embedded doorbell (off %#zx + %#x)\n",
+			bar, align_off, db_off);
+		goto set_status_err;
+	}
+
+	epf_test->db_variant = PCI_EPF_TEST_DB_EMBEDDED;
+
+	ret = request_irq(chan0->u.dma_chan_desc.irq,
+			  pci_epf_test_doorbell_embedded_irq_handler,
+			  IRQF_SHARED, irq_name, epf_test);
+	if (ret) {
+		dev_err(dev, "Failed to request embedded doorbell IRQ: %d\n",
+			chan0->u.dma_chan_desc.irq);
+		goto err_cleanup;
+	}
+	epf_test->db_irq = chan0->u.dma_chan_desc.irq;
+
+	reg->doorbell_data = cpu_to_le32(0);
+	reg->doorbell_bar = cpu_to_le32(bar);
+	reg->doorbell_offset = cpu_to_le32(align_off + db_off);
+
+	epf_test->db_bar.barno = bar;
+	epf_test->db_bar.size = epf->bar[bar].size;
+	epf_test->db_bar.flags = epf->bar[bar].flags;
+
+	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf_test->db_bar);
+	if (ret)
+		goto err_cleanup;
+
+	status |= STATUS_DOORBELL_ENABLE_SUCCESS;
+	reg->status = cpu_to_le32(status);
+	return;
+
+err_cleanup:
+	pci_epf_test_doorbell_cleanup(epf_test);
+set_status_err:
+	status |= STATUS_DOORBELL_ENABLE_FAIL;
+	reg->status = cpu_to_le32(status);
+}
+
+static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
+					 struct pci_epf_test_reg *reg)
+{
+	u32 flags = le32_to_cpu(reg->flags);
+
+	/* If already enabled, drop previous setup first. */
+	if (epf_test->db_variant != PCI_EPF_TEST_DB_NONE)
+		pci_epf_test_doorbell_cleanup(epf_test);
+
+	if (flags & FLAG_DB_EMBEDDED)
+		pci_epf_test_enable_doorbell_embedded(epf_test, reg);
+	else
+		pci_epf_test_enable_doorbell_msi(epf_test, reg);
+}
+
 static void pci_epf_test_disable_doorbell(struct pci_epf_test *epf_test,
 					  struct pci_epf_test_reg *reg)
 {
@@ -1309,6 +1482,9 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
 
 	cancel_delayed_work_sync(&epf_test->cmd_handler);
 	if (epc->init_complete) {
+		/* In case userspace never disabled doorbell explicitly. */
+		if (epf_test->db_variant != PCI_EPF_TEST_DB_NONE)
+			pci_epf_test_doorbell_cleanup(epf_test);
 		pci_epf_test_clean_dma_chan(epf_test);
 		pci_epf_test_clear_bar(epf);
 	}
@@ -1427,6 +1603,7 @@ static int pci_epf_test_probe(struct pci_epf *epf,
 		epf_test->bar_size[bar] = default_bar_size[bar];
 
 	INIT_DELAYED_WORK(&epf_test->cmd_handler, pci_epf_test_cmd_handler);
+	INIT_WORK(&epf_test->db_work, pci_epf_test_doorbell_embedded_work);
 
 	epf->event_ops = &pci_epf_test_event_ops;
 
-- 
2.51.0


