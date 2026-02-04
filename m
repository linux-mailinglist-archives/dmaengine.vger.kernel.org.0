Return-Path: <dmaengine+bounces-8724-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJnDIcJfg2mJlQMAu9opvQ
	(envelope-from <dmaengine+bounces-8724-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 16:03:30 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4DFE7D16
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 16:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65898312A01E
	for <lists+dmaengine@lfdr.de>; Wed,  4 Feb 2026 14:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81E242188D;
	Wed,  4 Feb 2026 14:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="COtQunve"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020123.outbound.protection.outlook.com [52.101.229.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A369B41C31E;
	Wed,  4 Feb 2026 14:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216893; cv=fail; b=CkDdp8r9DtNFhsbggFU7HcnUVuplI5h4bbUsJsZhhvXsEKteAmpdYFpXgFYvr3bbos30s0ttwUfKXkiI+gHcYrbrVrMF7MZlHDLtpUgiOIwfYc3u5sYk1xHt0gKKQG4Lfjw/i/Tqt5terdbOciTCxznYXnARD8AvbtWaZ7voQKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216893; c=relaxed/simple;
	bh=jLFj335Vo5tlFTvTPK0YO0+7A+iEJq3NcIXNuObSn2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tjPw1efZwdbpDu2haKwd9TFiQnWXkO+8A57ljyBoOyeQrD83I84rcqlV8kjGVu/leNiulWhMcg/W1ayLbui8Z/2g+l0Wj10vJz3YczNWQT6VkbBJiV9l+8T3Cnzl9jYmPKLaAE7aPSeNdlK4fzY2SqKl3GYT0tRmH2NZ6UsYYA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=COtQunve; arc=fail smtp.client-ip=52.101.229.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BXkKMB76CQ5UGQxR/zds+xo5R05wI4d3D92RSoyYBH0ScQOW73jdNeNEJRhjAPAnN3JQpAbqFMnQbnBDCknnNOWFne+/SmGqbbP5wNIgzT97RUJwgufx5b0kCgQRCAtEeNbRbSShA5BS2MeOZGNWzD9/9mDDCvc4/y5vkZZamwV6qId0PJ4DuLv7A8lWL7ORicfaJw2GttMYLD1JptUcKsmkhuo3UEweZyEwBk9m6KSyPuBkss84yHzst4Nb2CmiT9enzjmLE5QeZthclG02dzbKkLevCbfEJi1bxl1VIRevk4GysR53leohYKQPRhpZZ7HvkBM1QegXyjq5GNuxVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSmGhsqC8E3qz+cPAPson6GNm2uua/mZB8XngUcTFfg=;
 b=Fl+diwODwpVJgoQzXMydZKvDRaOaFd4nT8KAcSUgOhstDuRdDyYu+wmPLyHj4sAgtonFif4k1D2eNw53Uo4bu1+ZiwWMAVTQ1jMJN8u4UPBilKLK/UgLhrMSRwsyKjIAySfYSIOY+7iHiblvTzYTz8+EfBLiF1X2AhCZ5cpxVq2VrMKx01bA/oGEiMdxVuIiGsDJh0Jn8Dkl5jUN/xK5KK2nvUnqSoaRN0xuS9vMvv78jpDmsVn/4PVyW9giqOEbq2gEh5079scyQRgTq8+7pnXKnnY73sfd/sAemZlxhMm7vQE54kRG1xbo20s2gQ7IG1suTeN2veNujqU9FKs5gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSmGhsqC8E3qz+cPAPson6GNm2uua/mZB8XngUcTFfg=;
 b=COtQunvemhOb3awgfdULeAVSrXaYH0V4Uxg8N2yVCCR+ZRnMoxpagS3F2yNUF6tGnzVuV+FieD5nRg+6ffY34MaBSQkRuB3ekuQQOud3ur9/ygCmqTSXKKBTZCtsGaSJJeGJ7Bt+bCnBwGIaDZSh6GkulwcjRwBIHTdyorUjRqc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2976.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:302::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 14:54:52 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 14:54:52 +0000
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
Subject: [PATCH v3 06/11] PCI: endpoint: Add remote resource query API
Date: Wed,  4 Feb 2026 23:54:34 +0900
Message-ID: <20260204145440.950609-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260204145440.950609-1-den@valinux.co.jp>
References: <20260204145440.950609-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0025.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2976:EE_
X-MS-Office365-Filtering-Correlation-Id: c34883a3-235a-433a-c033-08de63fd59f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AQpFg22gWyNvay5Nu8OVYfUi/rJyID3y5zy4fKSYz9MK/x220CbHnS5sXZFw?=
 =?us-ascii?Q?6/YjqU5d6KNFv5zZ9/CUEDUaay69GhwvbqnQ/juto2T2a2egiQOhYplQWBQF?=
 =?us-ascii?Q?akdAlQKIzZbliOerkQY1bidDe2HjUHEHduBmfJlza+2iAGhjSAP4emSBbGZ+?=
 =?us-ascii?Q?/jcEfMaFf56N7UYVMKqRYJtvoOYlLkj7H620Vr6TlLDEkRKwxCd/jvL3bX69?=
 =?us-ascii?Q?jR7EoYo5HcAq94XgPzTtZO7FAxSl1MQhcMd4vmAJTQBnS6zpv99QUnQ3BGn/?=
 =?us-ascii?Q?2OfBY4sw9Jusfj6i7+KdgfRXJOUKOlrwvNoquj6bbIWR+FsY/ctuwbhPs4Md?=
 =?us-ascii?Q?JkI87Umty0cA+KmT3qumjPXKDteZ+qWHSuWGmKm8lwGzkZRcwDUnGUOpMw7R?=
 =?us-ascii?Q?ewR8xg75SnVkm/saWMfNS15r02jh4akXCBJ17cgOoqGDxYz0wjvVQp9T0FBs?=
 =?us-ascii?Q?h7ee5bdcqR1O3YDNCNNVkXThXI55gb3SpS3NHUCe3Lu1+Pg5rhgSOul/JAis?=
 =?us-ascii?Q?YR2FeTODJobU6v9endKToLaPDsQBjDGMr5pK+GBvNl3xcBLZ6bPBvpXOMhh+?=
 =?us-ascii?Q?YyYSa5F+JQPURZ09Bdlscb0tp9gBaOBkOG1+9A3SK66saOvOc1uHsVMEqkaJ?=
 =?us-ascii?Q?BCi0v4dQRTzt5PLh56cFb7Ap7SrVR0W5xZqIwJ62kgtiHlSyFwzoqvXscD7E?=
 =?us-ascii?Q?QRFx3cW+rZh04L4m38idS5rY0zvWvH/eXnl4Lte3yK2FQ8tVLWcuFdcfxlAr?=
 =?us-ascii?Q?3D/4AKQz2ClDh22j5qgQTEtNl9Sh9OpbbVVBGvfA/Nw5EWvwULtJ9GG7RL59?=
 =?us-ascii?Q?vvJxnTWcYSPa5xWU2fQ2l3qxoyQTwoGxWC8uNPQ49RHKNpDxPq+fiN6qbUBx?=
 =?us-ascii?Q?wJ5MYQ8eJ8ZqcyHdPAOk3eNDcnFOiJ1bmcnDxAM3NHZ0flWRuz+AUK8itDDo?=
 =?us-ascii?Q?KBIwVEMq0/TqM9pcOE/q1pH0Zb6jOfWyvFSudrWQZk6MQsjbECQvUnyofaeu?=
 =?us-ascii?Q?nO/sUWB98N1uPGdd8iKcAa1ixvWndaX/IRrodXgBKjKsKecVW/BlcK3+DC1N?=
 =?us-ascii?Q?0B3oS93lcCHbKv86vj5jbJ1rcdawNKQnmVmGwIXehrfCMRY7hz+pjV2K8K9V?=
 =?us-ascii?Q?F9Xuacx6P9qBzPTA8Xd6q5V17ig+uM3JLRHZArnlloZP++ZczmdzOZtXOpna?=
 =?us-ascii?Q?pHvm8Sn9IeOG1bXQZreZEQ1ExgJR/n79Ob9DwXdFr5NMyeWj9jguwOASGNiN?=
 =?us-ascii?Q?A0IHxql19P5syKW9qWOgXB1GHidtK9/g6jq+zYk8zy3Ca2SZOn6DPXdXRnzf?=
 =?us-ascii?Q?AIZKQVs3xOkVVCQxH+AHB7DUf7S1my9LGvdjhyh/UHLyeovGNdEKDUPKzW5k?=
 =?us-ascii?Q?AV9kWm1SnhFbOYgzcGR4sMc8jtOHZTCGw6XzkypR+n8TxEpsoE9mmi6lsZN8?=
 =?us-ascii?Q?xeH0kI/Qwbw2l1whK7igk4jWHno9lmQAtxbPLTurLCy+jklr7vS7zRWyUylT?=
 =?us-ascii?Q?c+pOCZyq2V37P4FJYLyw0FnlYxbvnycEpQ79zdBlrIaocbtJt1w0s5z62EK7?=
 =?us-ascii?Q?A7J8iwtqjTND2OgZoSs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0iMf3bg+Ilfc0cTfw6FR94DYouLsBN7Tq7bLSQA1imiwA0B5I5yw+LfgHsEV?=
 =?us-ascii?Q?FbdzfgOWvbnR3y/u3kpvBePb+EqytWBhdbNUVQPPcyVoIV6sI2Nz+JaQ18dQ?=
 =?us-ascii?Q?iw8TRtsnCEfhphlsEuTBz+CcKR1tC/J9NHYwn3qCpFxKFkQ7gjS506oVLfvy?=
 =?us-ascii?Q?ds9OaApjKTdeSynl9c7FhIwttxTop784WGgwLukyH4477nqhDBRkkQ8r1FAH?=
 =?us-ascii?Q?XcBJUwCeOFtEjW8aB5o1C4X31UflSg8jmvglM1KlYodYwmkjwWS41+nkLZWO?=
 =?us-ascii?Q?qoAYph0Gb+3JQp82VWznbKJcSww0yMinPXaIRxKHkWma9eRUqXyvbWJwpgGA?=
 =?us-ascii?Q?PFyV1SqU303OMxHoMunvVwetNIBNEhTLPIZnSh8C6xvo4HcPi2pGjc7yY44H?=
 =?us-ascii?Q?zEHID9iELHnef0OVNlC68or8YRQktCTQibmoJj/h8CKBFG713wR8HGBxouEF?=
 =?us-ascii?Q?wYNTm7mGuNAW0f4N7ZsOKE7xJTa5dbbcds9a+Wbuki8RUwxEF7+syNqqK0Wq?=
 =?us-ascii?Q?txH733GjosssyIpJxfL9nkmwDbfkGY0g2fZCnpNgpQZfAJ/whaSiXwxZ6ZEo?=
 =?us-ascii?Q?wCDXObKeHZKOI9G3uvWmIhRKdPchwOtRvHrVUIR+ZqDf7jZNRkhf4OlOFAZN?=
 =?us-ascii?Q?0RTkgjj2xAUNiXgIVE1G3FIUdi81vQUxud571LL5HKLnF8ZS5gAVrg+PxjT7?=
 =?us-ascii?Q?q7QNGFh8UUTRaAw94yl808TxU/uEuP8Kc0PstgMMYKvRxJbhLd0FJULRBm1a?=
 =?us-ascii?Q?dqUB8Y1mTVTy3Mso92OgN9G9GUPelQ7kliAouE2GHEvJf3YE3FNgVZ0p86Pr?=
 =?us-ascii?Q?HCB0H8d2EdEWm7FsrnZnPOhOYSkySaC/2xEkTtC2/DT7V8jPeelGuwlOfO9v?=
 =?us-ascii?Q?wp0IDhlCJZaOEGM9z4cH8fVS7BFOkYy7In1/fR5q3AEl+rNElwbIolCXSMrN?=
 =?us-ascii?Q?CWt4cNxR0OLfcyYwREG36aGOhJLiHRpCNFdv1BJVRS0ny+8NXfzals4zwwxF?=
 =?us-ascii?Q?3GkSEifPVrRCcwc98grzvf/hrjq7mBDdgEpyvtWHiZ8dnQ+RExnHhMhRTDaq?=
 =?us-ascii?Q?rzMQrvfX3cQvhLgmKL7cVD49poEez5zHMGN6qrMtid0z4u575S4VtHB22+JT?=
 =?us-ascii?Q?CqW2dI049LsRqgrPjfh6c1WJm6fWp1BWas1EAQzTR+dC8/ypyLL0Ay88vVZv?=
 =?us-ascii?Q?Fa8LkxRmuQwMulpdWCBx/yUWVFsJAcu2g6yLgVK3Vkg0myGoBsYe/SKjinbB?=
 =?us-ascii?Q?oyhmUhyQ2GpGGwoOYNwMof/dWEkPzqepx8ioUdVMJdGZqBvnTHLITpErsN+x?=
 =?us-ascii?Q?4UreC7lGX+m9/wyyn6I5hHtZfStbH2VYU/XKXwyMKOhAOcZpwAGwL9RCqrq+?=
 =?us-ascii?Q?Zn61LjbXRqa22Sm2C/1IYESelTtHQRf1UuWE+wLOnAD6eE7mvKnI1dk/pdDV?=
 =?us-ascii?Q?g0PA0hLF1BsCaF3X0aa2tdf1vxtycGLEV4rDwNrGn40i6sKlb0Wh1Ik3eKqU?=
 =?us-ascii?Q?ROE+FhfJycMMCJVcoEIcOqkkuSs26+U5TQcvYsiXkKattPSw4EH+udTdEAPL?=
 =?us-ascii?Q?+uW6Vf9FCQNXbYFP8IpA1Qoll5LvomFqB47DNodJc+yMb8NACVF70W/+yaGS?=
 =?us-ascii?Q?XDpWgJYm5wEQem2vGbO1KcFLKBjAE2yIMa6JeIXWZBFVN5A/1VEEffhm5HZh?=
 =?us-ascii?Q?+dbLAEoGKdkCfZltpm7u/LNfAeOwpyew/jUl3vk7zavPQY9CK529rXmFQukL?=
 =?us-ascii?Q?37G/JKBy8j+FqzlOuhItdLrKGzl4YWUPCDtW6RwedteEclloQ9Fr?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c34883a3-235a-433a-c033-08de63fd59f0
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 14:54:52.0513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hU6oQSQZKPgPTjc/9rNOZxUI345BefBif5exMd7HKVA1k1+NPqpL0QOOogScicA5jXMi4WhuxnC66OnctS7U2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2976
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-8724-lists,dmaengine=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,gmail.com,google.com];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,valinux.co.jp:dkim,valinux.co.jp:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1F4DFE7D16
X-Rspamd-Action: no action

Endpoint controller drivers may integrate auxiliary blocks (e.g. DMA
engines) whose register windows and descriptor memories metadata need to
be exposed to a remote peer. Endpoint function drivers need a generic
way to discover such resources without hard-coding controller-specific
helpers.

Add pci_epc_get_remote_resources() and the corresponding pci_epc_ops
get_remote_resources() callback. The API returns a list of resources
described by type, physical address and size, plus type-specific
metadata.

Passing resources == NULL (or num_resources == 0) returns the required
number of entries.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/pci-epc-core.c | 41 +++++++++++++++++++++++++
 include/linux/pci-epc.h             | 46 +++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 068155819c57..fa161113e24c 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -155,6 +155,47 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
 }
 EXPORT_SYMBOL_GPL(pci_epc_get_features);
 
+/**
+ * pci_epc_get_remote_resources() - query EPC-provided remote resources
+ * @epc: EPC device
+ * @func_no: function number
+ * @vfunc_no: virtual function number
+ * @resources: output array (may be NULL to query required count)
+ * @num_resources: size of @resources array in entries (0 when querying count)
+ *
+ * Some EPC backends integrate auxiliary blocks (e.g. DMA engines) whose control
+ * registers and/or descriptor memories can be exposed to the host by mapping
+ * them into BAR space. This helper queries the backend for such resources.
+ *
+ * Return:
+ *   * >= 0: number of resources returned (or required, if @resources is NULL)
+ *   * -EOPNOTSUPP: backend does not support remote resource queries
+ *   * other -errno on failure
+ */
+int pci_epc_get_remote_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+				 struct pci_epc_remote_resource *resources,
+				 int num_resources)
+{
+	int ret;
+
+	if (!epc || !epc->ops)
+		return -EINVAL;
+
+	if (func_no >= epc->max_functions)
+		return -EINVAL;
+
+	if (!epc->ops->get_remote_resources)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&epc->lock);
+	ret = epc->ops->get_remote_resources(epc, func_no, vfunc_no,
+					     resources, num_resources);
+	mutex_unlock(&epc->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_epc_get_remote_resources);
+
 /**
  * pci_epc_stop() - stop the PCI link
  * @epc: the link of the EPC device that has to be stopped
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index c021c7af175f..af60d4ad2f0e 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -61,6 +61,44 @@ struct pci_epc_map {
 	void __iomem	*virt_addr;
 };
 
+/**
+ * enum pci_epc_remote_resource_type - remote resource type identifiers
+ * @PCI_EPC_RR_DMA_CTRL_MMIO: Integrated DMA controller register window (MMIO)
+ * @PCI_EPC_RR_DMA_CHAN_DESC: Per-channel DMA descriptor
+ *
+ * EPC backends may expose auxiliary blocks (e.g. DMA engines) by mapping their
+ * register windows and descriptor memories into BAR space. This enum
+ * identifies the type of each exposable resource.
+ */
+enum pci_epc_remote_resource_type {
+	PCI_EPC_RR_DMA_CTRL_MMIO,
+	PCI_EPC_RR_DMA_CHAN_DESC,
+};
+
+/**
+ * struct pci_epc_remote_resource - a physical resource that can be exposed
+ * @type:      resource type, see enum pci_epc_remote_resource_type
+ * @phys_addr: physical base address of the resource
+ * @size:      size of the resource in bytes
+ * @u:         type-specific metadata
+ *
+ * For @PCI_EPC_RR_DMA_CHAN_DESC, @u.dma_chan_desc provides per-channel
+ * information.
+ */
+struct pci_epc_remote_resource {
+	enum pci_epc_remote_resource_type type;
+	phys_addr_t phys_addr;
+	resource_size_t size;
+
+	union {
+		/* PCI_EPC_RR_DMA_CHAN_DESC */
+		struct {
+			u16 hw_chan_id;
+			bool ep2rc;
+		} dma_chan_desc;
+	} u;
+};
+
 /**
  * struct pci_epc_ops - set of function pointers for performing EPC operations
  * @write_header: ops to populate configuration space header
@@ -84,6 +122,8 @@ struct pci_epc_map {
  * @start: ops to start the PCI link
  * @stop: ops to stop the PCI link
  * @get_features: ops to get the features supported by the EPC
+ * @get_remote_resources: ops to retrieve controller-owned resources that can be
+ *			  exposed to the remote host (optional)
  * @owner: the module owner containing the ops
  */
 struct pci_epc_ops {
@@ -115,6 +155,9 @@ struct pci_epc_ops {
 	void	(*stop)(struct pci_epc *epc);
 	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
 						       u8 func_no, u8 vfunc_no);
+	int	(*get_remote_resources)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+					struct pci_epc_remote_resource *resources,
+					int num_resources);
 	struct module *owner;
 };
 
@@ -309,6 +352,9 @@ int pci_epc_start(struct pci_epc *epc);
 void pci_epc_stop(struct pci_epc *epc);
 const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
 						    u8 func_no, u8 vfunc_no);
+int pci_epc_get_remote_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+				 struct pci_epc_remote_resource *resources,
+				 int num_resources);
 enum pci_barno
 pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
 enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
-- 
2.51.0


