Return-Path: <dmaengine+bounces-8843-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCucD/LYiWlUCQAAu9opvQ
	(envelope-from <dmaengine+bounces-8843-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 13:54:10 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9E210F2D2
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 13:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12B8F30297AD
	for <lists+dmaengine@lfdr.de>; Mon,  9 Feb 2026 12:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CC63783B1;
	Mon,  9 Feb 2026 12:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="vnf6yHzx"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020117.outbound.protection.outlook.com [52.101.228.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1BD374161;
	Mon,  9 Feb 2026 12:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770641604; cv=fail; b=jG6UvEIU60YwM6mZksWSL51Qmkb6pMMfvz9xGVfCDN/sqvV4luLo6l+FGYO17vl+IQgCor0AiI44+dV6SoUZPVYT2TwIC59rMIVny+T81MLwc/ujw2rqZOYGUAQ5ZrLn7Gv4ctyMDFRzIx5KJoOpXddpi721N5Q3biG40Eo6a0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770641604; c=relaxed/simple;
	bh=fTx60twlm8eOQQ0LDmn/cde81YfV1ISdp2/yz1EnxUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C8rl5RlWDHIyymSpYxGuSheKH3AD/m8ZZKn1ZodBcSypay2r+RdC0prKhXORgKLVeaxz2JEUw5ZspP1uOlbQ9c8ApSyrjzmdgst6gTh8ybYz+UlPmC2IMYNU3+cPtAtKUDA+1Y4s8ru+v59+ceRBqu9Um2E/STqTTCbv8HvcqNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=vnf6yHzx; arc=fail smtp.client-ip=52.101.228.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mfoKrP5r9vChSjuVYujBxBUMEh5sZR5C+sn0esWAtxEZL2s9pv2rdCGbaI7gi0qbRgRm7HfPVMHzB9xOQ/fj8Ny6iZ6cwNx4p1hoCA44g+C0WP4xCUvVU/kpEURyeAhByCA/Z79egZOIVUtZQXSGkJHdEmlrTaxh+Aew5KF3hPcmt5wPDC8MYmy+KTWp/oMFLuOPOIlfhlIWixbvJ8qQnOCtgjh97ozHPH2bvO+VTDP0KXQ3Eblw8q8hvdqmqy7h3FeM6vQi/cmj1FH8soV4D8OdxwZd1k7z3mLeAurIvktUAFQ1UCVaiiDVNLtK7Ua6tLWDvlTURZsgY8y/Qj7DJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8yWAfV8AJ5pPwl+Js3pT03l2aqXPjl9XVUFCNdR+xA=;
 b=jHZfQ9oQlfSPfsDfyomrTiZmMcZBdKyc7SpH6bhFvIouRp8x1xRyp0I+xNg8nHI9xd6ZmbHehCEF5X4i0yYgvu+YG9U5BkNETAEhbWlr0lS2pgOt3MUdXLmjwnFxh0dEM/L+jtzVCK8cdu9+J/GBcQrqohwK+TLUHt7KbWBZTf9jYbfsFPBGVOLbQzzH0duQmkkbJTOZrrPlPPWymh9rr7zZhX6B7oaomFmwS+Mz8/npFh5aZBWUiuV4tZh/xD85ski1+UPFolzhL66X8ElVSlz56jvDNOkLcnwzw5pljlOnVq/obHwe3KaRbbIbnJ4cZ4ij8DggDCV8iHhQNNm1XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8yWAfV8AJ5pPwl+Js3pT03l2aqXPjl9XVUFCNdR+xA=;
 b=vnf6yHzx/9SWio7etpmQJCbeNONsAZrioFmyveQBeDQKxoD0PrXdX9q5qFgThBkc8Jd86GkP04y9jhiain2D6VoFEJkwFN9PylKIbOEYSR7mM2AcWolkR2r3BLLS+/FTpJjXyHHPp2iMYOgdgt6WC10DWL+ePnh2pb3FXfnvJbM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB3742.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:237::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 12:53:22 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 12:53:22 +0000
From: Koichiro Den <den@valinux.co.jp>
To: vkoul@kernel.org,
	mani@kernel.org,
	Frank.Li@nxp.com,
	cassel@kernel.org,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	kishon@kernel.org,
	jdmason@kudzu.us,
	allenbh@gmail.com
Cc: dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/8] PCI: dwc: Record integrated eDMA register window
Date: Mon,  9 Feb 2026 21:53:12 +0900
Message-ID: <20260209125316.2132589-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209125316.2132589-1-den@valinux.co.jp>
References: <20260209125316.2132589-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0062.jpnprd01.prod.outlook.com
 (2603:1096:405:2::26) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB3742:EE_
X-MS-Office365-Filtering-Correlation-Id: c099eac4-4336-4a7a-65b2-08de67da34f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V/vAqrrV0T8oKwnf8WO8ekG8AjySd68w76/zeXbybtPGe+X3dxcqldmbKcvy?=
 =?us-ascii?Q?jjSQ2r5pYWiBkXCpkLd22zGBwfvJnqCwNA2JJT+rIFLdKQaaY+f8IV375Dwy?=
 =?us-ascii?Q?byJNgc/jZGZcJrsCT7rTrUAvuAp9XnzKzlGpc8+MKfPXtQswpPI6bLE7Y2Ro?=
 =?us-ascii?Q?QZjYkRYLi12Y3+3dTnUyXOOLOCimg9Qlz6/VQk99UldM8d+Hq99BLUvCKcCT?=
 =?us-ascii?Q?Jbb0P2gRA4xbaD9LP2VCs+r9OZZ5ksDWWTXn+9cWeBSSw8aAjCJkm6st0So4?=
 =?us-ascii?Q?Irz+bcCvQ/BorlEULc6NxoPSaCaMwt+0rLPY8LZrg/xJKX7bh/AN2iOWwMMI?=
 =?us-ascii?Q?l25+N4o2igxVbs+ACU3VV16qV72RW1MNn4H2I5cM2xED4Mq9P3F7ojmrEPFa?=
 =?us-ascii?Q?Ydmb15zg3L2wsxVtEQ3FbEHmu35y+m2DkLdw9Xpnyzq62rBdVm8GE2/0rybG?=
 =?us-ascii?Q?U5+Jr2UE2dz5avSGFxhjDhf7P6sfVLinblTIyd/y97oFeOz7ufMEI4AqDxtm?=
 =?us-ascii?Q?Nr1m871LOKckeD/8Ry2t1Tt2yF5+QlMiJB5+q9MafYQDhM5yKJ3Lhg4cTgc3?=
 =?us-ascii?Q?nxXTISppr4yFsJbdSgauLlWWXZWWAD4ffRzSg5fILJL1iCRi0ZE+4ru+QXqP?=
 =?us-ascii?Q?emG5FeA7BwOVshEyIPj6kk2lOXo2G83zHdaCOioeN77E/gm1JD0p7r1EUr7j?=
 =?us-ascii?Q?JWCsvLvyqSPXXH2l2DO+hHVXWZZUNP/Ru4xD5AtvPD8dLU2szfhfqaMhknZc?=
 =?us-ascii?Q?qoF4YVF2SG7zWcQezYxkOTP51WFBjYJCHdV1VBjeTb9wWWDVxHOCrf3Rr6pG?=
 =?us-ascii?Q?6D/P8ikd71zjDoH/A2UHkaqWKFL8g7hGKWhRJc0Uue4hLVdLwgRgfyeCXghP?=
 =?us-ascii?Q?k+qL+nkOyY+Q7BOK+6UB33RKzE9SYuggIe1fFjF1TPZGs9UglF4EzKo7JtVP?=
 =?us-ascii?Q?y5SsISLbBCcAJuacYYxOf8YYTZAiYv4wyPHhF46KMe7AOIuKZ1uWvB0hyUsF?=
 =?us-ascii?Q?sBeSiu/lPL5h2nYD9RXJKu2g5tqcE32BpPh3QDKu4KKIVQ1TmJvp145vzhY7?=
 =?us-ascii?Q?/Xq2kPL95AvnbDCDYJVEmhnlRKBPpr3ldg0gnlrMZQv5H0cCB3NPnKhrrqhS?=
 =?us-ascii?Q?rO24zlf0Rw6pj5OAG1KeF+2fP7KVJvODxoiMqXfZjzSJOZsEiklwl16S5Ai7?=
 =?us-ascii?Q?NF72kd8ByXgkBnG1cbfmNvVJq+s5sfSMsXKLx492+qEV8U+KWkFOFn0NJYTx?=
 =?us-ascii?Q?7n28PhbQWT98lCyUrOtcklLWfcHCpHhAbi0XsDuU+6lARU9iDzOpDtfjaFOM?=
 =?us-ascii?Q?glqcICZu3+dY0ooF85ENmRiEYL+RNiZCALpw9APrlKBBp932wEbjOacJhDRr?=
 =?us-ascii?Q?Jw5z+Jq/1Q4enbVZlkdeD9n/UcKeIZHqD8RxjxniXfuMYkdcnPKoQLQ3RJ/1?=
 =?us-ascii?Q?FxX+uIAWhPFxU4rLiN0V/LCxJV3xUPm6lBGYeB0tBVnwwOvVP8HZDgNxeOzv?=
 =?us-ascii?Q?u1xIJH5YUtkOaWuBp9O/0CPMXcLb2H/in9/jMDuAKsmYPEfHtUZISHI9kjqC?=
 =?us-ascii?Q?68awrxRR4VYYch6bWNuBv5yjMWGC5V/n/zSgx9HB6QBRzamk7Q1dRfkCqK9g?=
 =?us-ascii?Q?IQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SBtTOHyBGDfc/ttd2nn20iScJfLCUpGaaT/GBC1pxspFPakfHP1+/L9W2o+5?=
 =?us-ascii?Q?LjDJEeXy0EWpvzljWd/mODreJP60C0O/rIdF8XSKpgyCsLAtmhUysyaM33OB?=
 =?us-ascii?Q?KFszJXOwJND7iZ3L4BcVo4nUbi1s3tb0kulKbQRlsP5fUd2Zg6byLvkhMQyK?=
 =?us-ascii?Q?hzI1lzVjfA8tGdZc0D+/Cg7Q30uuLgeE7SOFvuLB+HSQ/cm4tBY7rAu+xtj1?=
 =?us-ascii?Q?naAv8n3wmNsmx7+YsvBBslVuQV6PpwcvJC5LSFG4L5T7LbMS/gESdn5M8hoM?=
 =?us-ascii?Q?0ajcKiaGPN+NrLN/nWmvB0g6sSq7Y3XLutRLziToG6slDqGCBGEvLj/tJxeW?=
 =?us-ascii?Q?RRzQHNURdZRyZKTeFsBx26NKr+T0zK7WRjk6sLD1XAjFMQou/GWMvHh4izLi?=
 =?us-ascii?Q?+XxFf+aam/X3SZ1SlZUOVM1Kjxm9+qlNihQUxvQVYYJYL6Gx/UyTPXqXhwlh?=
 =?us-ascii?Q?EHPWq+KfNP+Axfin2pkNllxcvP0JeQO63C2zlc1fthGztWmWPv0VTbhWJpEB?=
 =?us-ascii?Q?b9pS7n8vmZK28K2c4GTd94vT3rNEo+EH3SHCPr4Q9l7i2Ef07lhWRYDwTZ8i?=
 =?us-ascii?Q?xkDJFamzewieQJLeAGuSbNAghj0LnBN3CdgnnYuDWuSZYrmmoLtDdwYFQUu6?=
 =?us-ascii?Q?zBcXdkH6OrfnQnJoB0D+DUYChO0q1qZopTmx8LaaxxueG3XEQ3bMS/IYRH5z?=
 =?us-ascii?Q?Dh4v7jo/s10Szx7d6Umg0hm26CWP6FTgxnYehznUmtlX7/KFXpOQrE2TsfM6?=
 =?us-ascii?Q?1y0tCmfqpIx6hhmKlaK89ukVDNp6aV8Zy2dYq2QFIwnlHZzKcCGJrSCH7KMw?=
 =?us-ascii?Q?dpeF5fqk4gKSfI3AYeos67TEjDoYTMhpGTZBIvHYve57VD/9iqMLLz4GzysX?=
 =?us-ascii?Q?MTUcuA0+h6Bxvtfq7EGaRWzdVqqPQbZjmwE/rhWGfw4+FYq5GQTQp37knFdj?=
 =?us-ascii?Q?MiADsI0pvbgOYB7WLW5TThf+Eitm03OoHjed7P5D0QBiPnv7XX1GxAcC1qop?=
 =?us-ascii?Q?fzx7WCt+HUeVQLKS5RgPYblg7xLi8ai6mnVip9Sl4WOdlcDNXYoWM8OX4Ru/?=
 =?us-ascii?Q?fTefWgzVb5wAlnclcWOx3ug2pu3gp7Fzl9iCidDH6Ylus/8QUPvvcqW0q8QF?=
 =?us-ascii?Q?P5ebRiJ8zyNMPcZTF1iYVBxPSQyAoWI6GLaVVrUqTY6bqDW708uwVvhjDPXi?=
 =?us-ascii?Q?mNBtHAro4ZsCKxHo5KeWqM5UgWhAlq07mJqq19b9VI7A11zqhj09sChc7ISd?=
 =?us-ascii?Q?UX1olBXYaW/eF9ZtNhRpFNnBdzVGKoa0cTSLl9gObZZCOptkT1Y3F70so6qZ?=
 =?us-ascii?Q?Zq9h1lCx7tny2n/SqEa6If8IoPzstMcAZ+1yyik+r0uifyKN0F3NWhhPg/lp?=
 =?us-ascii?Q?qC2YKQUMfWcJWCLCeY3yqJQXVk/pIoaj3ZT2hudBSXAOIya6uCn9nRpxLnCO?=
 =?us-ascii?Q?LiFR3ItFrXgbbhGxb49V3UVXQ40m7bVXRR3vqyefyzMK3u37YREfMpE5Wtyo?=
 =?us-ascii?Q?Uwc5Pu6K0uj1AzLyZwmvb9K+2gwPtdUQcwJLAPjkko1420F08l6LsEcLv9mm?=
 =?us-ascii?Q?qQoMUDZusDNilvYfbRJbbMZ4BCaTM/WUYYhixeVTeJxgDtyTDG9p3C/larFd?=
 =?us-ascii?Q?D3WxwyROSOY3MKOjIQdiarVFmj9UkYBClSY6DxLLgHfejVcje4gMJV8CEKPj?=
 =?us-ascii?Q?9lTgh4PPCXv4RyFH0bPCWBywvNXOv8ccIVUzi8jMiKG8byAE0kk8xBhgVAtK?=
 =?us-ascii?Q?wzMfR6bAGURGBxYOknORcOA40aFnARMtz0/aZPOCSXX5FkYeBqXt?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c099eac4-4336-4a7a-65b2-08de67da34f7
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 12:53:22.2872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wfhUCgr7XZ7nwsrTZFhjerGX6hzCi2wZ6pEIC5UMQuVqLiVMkMdIkX1Vf926llj0UZI5k8utsMT3WO7EfVcnAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB3742
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
	TAGGED_FROM(0.00)[bounces-8843-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,gmail.com,google.com,kudzu.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DD9E210F2D2
X-Rspamd-Action: no action

Some DesignWare PCIe controllers integrate an eDMA block whose registers
are located in a dedicated register window. Endpoint function drivers
may need the physical base and size of this window to map/expose it to a
peer.

Record the physical base and size of the integrated eDMA register window
in struct dw_pcie.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/controller/dwc/pcie-designware.c | 4 ++++
 drivers/pci/controller/dwc/pcie-designware.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 5741c09dde7f..f82ed189f6ae 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -162,8 +162,12 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
 			pci->edma.reg_base = devm_ioremap_resource(pci->dev, res);
 			if (IS_ERR(pci->edma.reg_base))
 				return PTR_ERR(pci->edma.reg_base);
+			pci->edma_reg_phys = res->start;
+			pci->edma_reg_size = resource_size(res);
 		} else if (pci->atu_size >= 2 * DEFAULT_DBI_DMA_OFFSET) {
 			pci->edma.reg_base = pci->atu_base + DEFAULT_DBI_DMA_OFFSET;
+			pci->edma_reg_phys = pci->atu_phys_addr + DEFAULT_DBI_DMA_OFFSET;
+			pci->edma_reg_size = pci->atu_size - DEFAULT_DBI_DMA_OFFSET;
 		}
 	}
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 43d7606bc987..88e4a9e514e8 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -542,6 +542,8 @@ struct dw_pcie {
 	int			max_link_speed;
 	u8			n_fts[2];
 	struct dw_edma_chip	edma;
+	phys_addr_t		edma_reg_phys;
+	resource_size_t		edma_reg_size;
 	bool			l1ss_support;	/* L1 PM Substates support */
 	struct clk_bulk_data	app_clks[DW_PCIE_NUM_APP_CLKS];
 	struct clk_bulk_data	core_clks[DW_PCIE_NUM_CORE_CLKS];
-- 
2.51.0


