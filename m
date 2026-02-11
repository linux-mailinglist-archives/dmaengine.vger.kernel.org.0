Return-Path: <dmaengine+bounces-8885-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPXHJ4ypjGlHsAAAu9opvQ
	(envelope-from <dmaengine+bounces-8885-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 11 Feb 2026 17:08:44 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1D5125F8D
	for <lists+dmaengine@lfdr.de>; Wed, 11 Feb 2026 17:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96CD63019196
	for <lists+dmaengine@lfdr.de>; Wed, 11 Feb 2026 16:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0B9339719;
	Wed, 11 Feb 2026 16:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="QTiPxUXd"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020075.outbound.protection.outlook.com [52.101.229.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FB8332911;
	Wed, 11 Feb 2026 16:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770826112; cv=fail; b=eAXrI1pjZ2J8HcVYeKXQHP1g5QDLtx3OdLw8KDOe3sJtOtUloJ3413pJyV5sh/5+/DA/4kDaDucuwF6/oUew57oXDph+oUoRIZKfcOIJFaawfB8yfmW7nKBoppfnyrSkbFeVFE9GJi+oiPF8h327OdX3PFzGnUfI5o3Z5EWDlmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770826112; c=relaxed/simple;
	bh=Jb0Cl+iGKzIAfnKRzuLLpy9KNq3I8rIGOGlyLINJToE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DJj/CXYx4Hcwy+TXMihSFegODjzGPC1E8UgcFCKvO8fQay2bvkoU8grEtae3tCE5qweCYhUAfuVMkCMZQDz4vHgJ1v8cDKT7pJAUmUqrcCEe+oJf1/X5aGc75ceUV4a6u4A3IlYTWZerULguk0a5BuE5J5BLjdX9tHZZ/uRL+Ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=QTiPxUXd; arc=fail smtp.client-ip=52.101.229.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kApds/yg3Ezo1/MmHRtnk9Do0EoLwsye97oi8BpEOMEcz6DXuUrUJ4oWoxsHfHVggNm+4cbP2ps5vHy32W+03pye9rnreOt99ekVJ+jDwbKxA1fso0ntS9oWf7A4qsJ/eRcRVjkABHHUFND9YdRgqI7EjYVZPya4P7Y3kKrkkCDCbnwYww9k7Vgpv1h2jVgl/WzwfY1hLBDItPmnUQy1BpmkgWPZxw1UhdaySN0LWpBGvJHxkCry2g5l1HKIpXcd0vMZV554CpSAmUWzHU2+FlbQbDOV4rqzG1XmKliSUEh4acPADWYYjlgKqqKalD+m3hjesfC/CjgTF/EGhwFvBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dar+D+UhvGwXLxpfAjtRly2boXJRk8oWbtv9PiL7c30=;
 b=hac7FtJeSK8FJvU+GvN55Oj1+jui3JXsI9vo8cLAzRRTBUKDetshiJ1oyUFXi4EGPRjmDVPLyYkEfAgYJ3t0X5D1TeYcoJX7X55eESCgpcnc7QUf5bnCZerP/NkZNeKvYRuimm7iCS+YCIL+mw4QuRflZg7XqH2cSA7SiX+DfEl64Unm7PAsaXUw3GnB+D3QpUPy6I6toDHcGHmUcdZO+k5VFhQTL/KFRCue2hLw0tV1DO0kfd2628zldsC9DTJ8OAcIIQSrQ3BAUB+G+0f9B9SW7HtBHhmb5y7WkuVjxbtgqJkcGGXcpsR0+iBAPacx7NyQn0Dk4u6UPWeSoXnfEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dar+D+UhvGwXLxpfAjtRly2boXJRk8oWbtv9PiL7c30=;
 b=QTiPxUXd77pnwR7xjrobV/e6/4QMxjjooxeTKaB5+0pVXV6I5XqzTsvPgKjWtit1PNM11EQK/fcg2fmKbTdsJ+wCe3EiGdslmU+HVK0gAgPA3/4mmQz/wJEXqVNtvyI6pO1iyh6ofeXznf/SRxB9H8z6jpHW4ncSxP94+fIog3U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB7030.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:415::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Wed, 11 Feb
 2026 16:08:27 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 16:08:27 +0000
Date: Thu, 12 Feb 2026 01:08:26 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: vkoul@kernel.org, mani@kernel.org, Frank.Li@nxp.com, 
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, kishon@kernel.org, jdmason@kudzu.us, allenbh@gmail.com, 
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, ntb@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 6/8] PCI: endpoint: pci-epf-test: Don't free doorbell
 IRQ unless requested
Message-ID: <wlaklhyehjst25whwu46lffvhphftoksaxdydvkcmm3f3ucmfv@p7mzylpmlka3>
References: <20260209125316.2132589-1-den@valinux.co.jp>
 <20260209125316.2132589-7-den@valinux.co.jp>
 <aYsmTbSmn94J6uN0@ryzen>
 <uvuugqkiaravp6gmn6o7x5koyvo5zkmbwwbhdq6ctvvdtdhoyd@rnxwhlysqs7d>
 <aYte-7hTxb7kXNlQ@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYte-7hTxb7kXNlQ@ryzen>
X-ClientProxiedBy: TYCP286CA0277.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB7030:EE_
X-MS-Office365-Filtering-Correlation-Id: ad1b8924-6fa8-422f-bb46-08de6987ca9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hyiyQkp8MLxdBLob+ZBXNETZC095THCxT9sWu8sYZOiW7GYAIjOwkhDSkLRa?=
 =?us-ascii?Q?e07V38EgUQpV0zf1MlPByKgrNrOaU7b7BWNWgiAHkskrovukyCB2EqFza0GD?=
 =?us-ascii?Q?yoRqPPVSIDKOMSJqb8BUbYgtLGNNpahKpngt5MEhIVlYfWuFRWa2v7LiJFqa?=
 =?us-ascii?Q?gM0YtY92DPz/PORtyaxbPbytKwTooyhJyFoABPpQKLWFtWsu869WWpiJ5cay?=
 =?us-ascii?Q?H76oDSrjyAqn9fe06ounBE4DHxD4brRF4C7J7I4C5zxUK0zapnZrBNS6NMX8?=
 =?us-ascii?Q?c5C5SpgSJ0gggpOHzQR8UsT26APuY1dXL8a5R5D/95bz0iMEA61UfWGlhpFK?=
 =?us-ascii?Q?9B/r34pakGn3wn7mZzYUFn4l7mbGgqG3wgiHIM2EtSX6/dW1mY6kHmrVq7S8?=
 =?us-ascii?Q?23JMM5ZDdHf2NPfIZdaln2Inp7BxJWcPoV2LtCzURykRiQVr9t1QLrIslfrx?=
 =?us-ascii?Q?Spo45MMY9tRjHofL7ywkyVNMYn18ajDz9huk9nnyLFFOaIUa3AFCRcCKfZXb?=
 =?us-ascii?Q?zFQzwjRbKCUM+Ib0u/Qi/Q0fBbrX5SOlW/g+NPT5nC/dwVATWSThA9TYTrIG?=
 =?us-ascii?Q?nIeaZm8KMxMZLZ2N2Q0CvqVtUtcitaBa2sHc1Z5L39OXPA4REdZR21r2v3BF?=
 =?us-ascii?Q?c8M4X3DojL7c4kXWu4vz0ukN1oNFy63p9AJh6hdJ9fstVkG5mAj98l9pfTnc?=
 =?us-ascii?Q?EDo4V7Z8Brxeo6blp6/q0GekmA2OgrY1fjreNCeewr0nN3xCrG6ovTZBQ/hN?=
 =?us-ascii?Q?FvqnD4vx35a45rL5evfbsEArEoB5FV9BEN82K+okoUiTQ+ZKEehD8WSmRFOT?=
 =?us-ascii?Q?PkJZimxMAABEPFod0ML8mEe/p5u23WZBqjhWq0LvJYlmtWBQceBdBmWDu1Lb?=
 =?us-ascii?Q?ngZJ+kaZT38OJERUG5LzmBALrIAh7s7dSItJ8iws7xxHsqUFviUE+l868eau?=
 =?us-ascii?Q?tgWKfL6IVgNXhccchg5rO0p1VkRVe2z8jiVcm0aExo/0xHDbp4JMqjQ+WZj0?=
 =?us-ascii?Q?SO/lBv4Q2/H3DVaa686fAQFS5eokRFe9/TWlIoJy1jhsosU40czxiDyr4/WP?=
 =?us-ascii?Q?P2xdKiDbmGiH7ksV3w08Wt/8rKKrv9enHBz7EskL5vySx+PRYfwEm3w9O2iB?=
 =?us-ascii?Q?DZV2n+Gu3urvb8U1VvuK0eRYmqQn3J/ElnmPtTP+1mgQo1KnPqKBzoln5WXF?=
 =?us-ascii?Q?VhL10YILgwi7RwI1en3ERkVvZRoZfmA8MOtDXwex7BKkjaLFq+R2gnaAVlE1?=
 =?us-ascii?Q?gIafslcF8Fl82GxrpntghNNlDQruJpNNzckuWZrc2VDANtd4/t6Gwouz+NmB?=
 =?us-ascii?Q?7+SinaNfzpwan4j54YnGAsdbqDkN18vdIZnffdbSgBeF/CHJxfh64MTXubU0?=
 =?us-ascii?Q?ubHLSsRFhBKoi2/UYeOEALm2/yUiwJPiX0vmelL2bRbuwIVHD5Gic36Ocd/Q?=
 =?us-ascii?Q?M39wUDgOA/Ei+swUcmrUh/MU57EIfQeZJKwVCNt15smYQwXizrIOC9UY5qY/?=
 =?us-ascii?Q?oEZcpxhu7oZs5vpYl7cr1zErthxu7M4rxosE3+Sq4J2YJn9Wj+mN/hCeLPU3?=
 =?us-ascii?Q?KbjVnvV2N8mxIzyxn/A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zfpku+xGpkMLgRyt637UW1UPzBc5f9oJfGpyJ9aP7ipjIt2N7fpQQTJcE8sT?=
 =?us-ascii?Q?MoR4id9y3zQq7WnlyqWGZZK4Q59Pnl3npljR25JbP1nUbHacFpzUZ/E0A62E?=
 =?us-ascii?Q?lsbv8b0cflrlxHHl3VlvxkUC4tHpz1nnQfZHTSAMgT93qrqkk9CPcy+FXu9x?=
 =?us-ascii?Q?FzfeNhG+XAZoCOB1BPPtPZSJxr3ASKv5DokvMlT6yHzpwHccJWjTiSch6+EF?=
 =?us-ascii?Q?x/UZkOxPxfgTZXSsP6jyYQMFf0RD6ozX+cbYKa1KTMm0LvzhTUCDn2bMeWUX?=
 =?us-ascii?Q?vMoAZfcDB5xb4RgwMb0DvjPtlx4E9jN/9CazVG8H3zWLDqULGt06/X9VqgNl?=
 =?us-ascii?Q?XT0dsLI2mUoMwrTtB4JBrHqrLV4RppFtuImt55DwLW5TKw1X99FlSpZ1BneJ?=
 =?us-ascii?Q?XI4bTcDfxc4uZUFtWqsMkGQ2YXM69+f3akAdubLDVm1rs49XrNNpLFbB2NoU?=
 =?us-ascii?Q?uq87ClsndNZW+yYNwqmA7OJ+NM2elSnU3EgQoCRJV7NQvWPZ82t20v5TAjs+?=
 =?us-ascii?Q?r8FIDm1eZLWCy6rOLcx2fCcdLsehuSp2Rbl1sCxR44R5/zouS9qzlNob5bvJ?=
 =?us-ascii?Q?x7/hRmVjVQALaV3X3C0lxipxRW9sDjz8/PO1ujvk8Pno8zUVnNc+TBMZrqTa?=
 =?us-ascii?Q?+7gqKgJRgd1IaHKHTcQkTQkOWKknUxkHPBji9UfSSVQ47pc0d5yNUWNw02q8?=
 =?us-ascii?Q?udDb5c0/6uGD6O+fJH/el0li9PK4TW0HiYQdSM3Olf8jlFnxdR+xWQGtLyl0?=
 =?us-ascii?Q?3l/Ekxx4KWwQpsyTdOoiAfpBnHThIe856mXzYTl6Cr6GjUbME0lHpjbPbpUl?=
 =?us-ascii?Q?m/RYcGB1G7xXgkqxnGq/zECqDosOTGlmhedKBtAXUvOk2q1ZifSof8g1Lm/E?=
 =?us-ascii?Q?YDK3dWIZ1Gyiy4HYDbNW1AsLQmRxmY64h+WBava4V2TzhpoigwRbo5Pd1dTg?=
 =?us-ascii?Q?CUYrlRwF+fUTub4JIOKwezHKOqKLwQsN0QcrTnNB3mfNykqZQvs+j2SAFQcb?=
 =?us-ascii?Q?oVGS3ROg2b8tqV+NiehSPtsdhM8NPaOBrIirhOKJxKybZ4u4s69OmJZNioy7?=
 =?us-ascii?Q?dSLzxVqcQ8+9SIB2lDQRo85KeTaljAhhzmVbKNA1umw+2/qar1GHNxjUMu4+?=
 =?us-ascii?Q?2MwwmHblcE0euA81unrQCzEDMsWow2HJABKlVyrrWTaJcsFfpqjKqzsw7Adj?=
 =?us-ascii?Q?hc4CjMZZbXqn49A6z8rC4NMatzW325ds7x6khUsCjhw8bZ3CjUl+7kNTnHz2?=
 =?us-ascii?Q?zgpSCBS5PiAb+7OHZlJgPMLggIkrO8EJrfVYhTjbT9nLOx2CvX2wL2tzWRlw?=
 =?us-ascii?Q?2fqkr/sKnWAXmFKVSXiSWufwAlpImu7QsI8PxqBiD8jTpCKMrFRwpbNASXAE?=
 =?us-ascii?Q?Ylo0oRxj76Rbp9HlKaYVOr1UEDZn9lJCML36KMtPfmbz7K9e4A2LwenB3ZRG?=
 =?us-ascii?Q?drM+BaYhiZukXSdPOcPtpYhTTOnVweS0QBCWxf7+DtemP/xFzG8fV4RbCm37?=
 =?us-ascii?Q?4jlccBr2LrhuztWMR1sDG3/u7jGe8MfTu7UPOzUsIkCeIGlvCE1VSH1rZ5Kq?=
 =?us-ascii?Q?vq173Ask/bMroJr3vVAxWNfXMBpRQBulBK7tW6IUru0dVo7rwtOrjCemdhmK?=
 =?us-ascii?Q?/ksuoGd6w0dnI8V3iVjUq4zmB0fvpMSSOLtJqcsl4BZ9qSaD6bLIMB8q8NHA?=
 =?us-ascii?Q?Yeh5SM/d5mUyTS3ZPhx2noABoyKd2oCB9CNgIy4bYrUEJEHZ7nBwJo8s2mgg?=
 =?us-ascii?Q?vbR1QEGLoTQQTJUrWKD5JUbesUQt/ro5Q5bj4/ZPC3STwZi5f997?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1b8924-6fa8-422f-bb46-08de6987ca9c
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 16:08:27.4650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7AAuHDYjLsCXUG7ZcXM3HYW20WIkVXIvbHLbQDHWiQ60H4FmonL6dqtgGBoL8IDbY0Z7N8RPkLDvel583Av+0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7030
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8885-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,gmail.com,google.com,kudzu.us,vger.kernel.org,lists.linux.dev];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,valinux.co.jp:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1C1D5125F8D
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 05:38:19PM +0100, Niklas Cassel wrote:
> On Tue, Feb 10, 2026 at 10:54:20PM +0900, Koichiro Den wrote:
> > On Tue, Feb 10, 2026 at 01:36:29PM +0100, Niklas Cassel wrote:
> > > On Mon, Feb 09, 2026 at 09:53:14PM +0900, Koichiro Den wrote:
> > > > pci_epf_test_enable_doorbell() allocates a doorbell and then installs
> > > > the interrupt handler with request_threaded_irq(). On failures before
> > > > the IRQ is successfully requested (e.g. no free BAR,
> > > > request_threaded_irq() failure), the error path jumps to
> > > > err_doorbell_cleanup and calls pci_epf_test_doorbell_cleanup().
> > > > 
> > > > pci_epf_test_doorbell_cleanup() unconditionally calls free_irq() for the
> > > > doorbell virq, which can trigger "Trying to free already-free IRQ"
> > > > warnings when the IRQ was never requested.
> > > > 
> > > > Track whether the doorbell IRQ has been successfully requested and only
> > > > call free_irq() when it has.
> > > > 
> > > > Fixes: eff0c286aa91 ("PCI: endpoint: pci-epf-test: Add doorbell test support")
> > > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > > ---
> > > >  drivers/pci/endpoint/functions/pci-epf-test.c | 9 ++++++++-
> > > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > > index 6952ee418622..23034f548c90 100644
> > > > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > > > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > > @@ -86,6 +86,7 @@ struct pci_epf_test {
> > > >  	bool			dma_private;
> > > >  	const struct pci_epc_features *epc_features;
> > > >  	struct pci_epf_bar	db_bar;
> > > > +	bool			db_irq_requested;
> > > >  	size_t			bar_size[PCI_STD_NUM_BARS];
> > > >  };
> > > >  
> > > > @@ -715,7 +716,10 @@ static void pci_epf_test_doorbell_cleanup(struct pci_epf_test *epf_test)
> > > >  	struct pci_epf_test_reg *reg = epf_test->reg[epf_test->test_reg_bar];
> > > >  	struct pci_epf *epf = epf_test->epf;
> > > >  
> > > > -	free_irq(epf->db_msg[0].virq, epf_test);
> > > > +	if (epf_test->db_irq_requested && epf->db_msg) {
> > > > +		free_irq(epf->db_msg[0].virq, epf_test);
> > > > +		epf_test->db_irq_requested = false;
> > > > +	}
> > > >  	reg->doorbell_bar = cpu_to_le32(NO_BAR);
> > > >  
> > > >  	pci_epf_free_doorbell(epf);
> > > > @@ -741,6 +745,8 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
> > > >  	if (bar < BAR_0)
> > > >  		goto err_doorbell_cleanup;
> > > >  
> > > > +	epf_test->db_irq_requested = false;
> > > > +
> > > >  	ret = request_threaded_irq(epf->db_msg[0].virq, NULL,
> > > >  				   pci_epf_test_doorbell_handler, IRQF_ONESHOT,
> > > >  				   "pci-ep-test-doorbell", epf_test);
> > > 
> > > Another bug in pci_epf_test_enable_doorbell():
> > > 
> > > Since we reuse the BAR size, and use dynamic inbound mapping,
> > > what if the returned DB offset is larger than epf->bar[bar].size ?
> > > 
> > > I think we need something like this before calling pci_epc_set_bar():
> > > 
> > > if (reg->doorbell_offset >= epf->bar[bar].size)
> > >     goto err_doorbell_cleanup;
> > 
> > Right, I remember this coming up in another thread.
> > 
> > If there are no objections from either of you, I'm happy to include a fix
> > patch for this in v7.
> 
> No objection from me.
> 
> 
> Ideally I would also like:
> 
> 	if (!(test->ep_caps & CAP_DYNAMIC_INBOUND_MAPPING))
> 		return -EOPNOTSUPP;
> 
> and that the pci_endpoint_test selftest would return skip on -EOPNOTSUPP,
> since the doorbell test currently relies on CAP_DYNAMIC_INBOUND_MAPPING,
> but that might make your series too big.

That makes sense. I'll consider posting a stand-alone patch for that
separately.

Best regards,
Koichiro

> 
> 
> Thus, I'm happy if you add a safety check for:
> reg->doorbell_offset >= epf->bar[bar].size
> 
> 
> Kind regards,
> Niklas
> 

