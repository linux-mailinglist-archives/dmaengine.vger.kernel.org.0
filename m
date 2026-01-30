Return-Path: <dmaengine+bounces-8591-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PAXAM5afGkYMAIAu9opvQ
	(envelope-from <dmaengine+bounces-8591-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 08:16:30 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 673C6B7D2E
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 08:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDC533015D2A
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 07:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61120284898;
	Fri, 30 Jan 2026 07:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="pe7QWUqJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020089.outbound.protection.outlook.com [52.101.228.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230582C326F;
	Fri, 30 Jan 2026 07:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769757378; cv=fail; b=olLzb+0YfiWvZFv7LXzHh2kuUqG37+ryrLEOHn2QBaTfPLcIxWP2zMU1ClUPsT5krPMjDYMt4jxu4neyNg3IuVHD2eWtgF85ZOlp9HakpYu0jJikZakdAYEdpOpLRG+PLx3KUyUXJHPew7xuMZlwt9jsrmmnHZ+RXQ2FORgyP6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769757378; c=relaxed/simple;
	bh=C8KCYtQrQZkq2uep6uu/QwLZhQFyhLLFDgd5Wh9xEwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IMg/k1FB2diQLvBMs++Q1GHmasYcaf0r44KvurRqStG7EEq+5cjNVqUrtAPgGq2B+OLAaUEPVb0revJvgFUJKa+F8LS+V0y9urkceDglkoLm/KvIkjNX8dNp1tZb6mIiIrNQNhj8LSKE4Hey0hTNQ+5/FqFuEFoDa1owSLs7eEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=pe7QWUqJ; arc=fail smtp.client-ip=52.101.228.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YJlJes4r5DiDqAxgnS+ndkVV0virsF6hRL3u9cCh7ijU0PBAQQ2mOzoZ4gubpiJsBPJVkzaPcTlsULw3/Oj3sr1EDSWrGRYg5umwO1AOd+fYzk+iMTcElovLNk1UASSLN4MEcFK3532fLJkfenAULCvO654s9mfnqYJPeEeF4sU9RBohn4S3pRYfxgQpWiRmLzj4RdktEmmRmDxuN8Fw6djW0A3UgqBnf0Z0j8DiAL70EDwMFy97bg4g1x4dK5YcjiRKVeEJ2BbfHp28+/1iFdL1sHVP+c28n/SyZB/WV07P9WVa//vYQVq8EbnoexpSXO3LdWpBZn4NIJlUvzpleQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/kdFe6iMHAXLDEl9uLfXXhjQvS9dw4/xA78k8IDBfk=;
 b=b4fekuOOqgsMvnbqgFs/wy6LCDRPZ9wkn5sJuHkdlYnSOMYpCyvzNxtsxRVTftVS4sVTUvBUTkR6JPmD7PAoXH0icbKQ5Aq4AUZsbsWubkrNEd9YC+GBYltMrA/XmCbSBjDLdk32VZ5CjqDfg1UIHNQurg9uZ3P1HzZx+22quhDBB3elIubmLCtcmoiTjST318r7NzwZqCSNleb9xtfgWdBfvmkSHIYq0KPisYvLWlvVDvR7EI9Klupf1/eQ2egx2FQq4gP6CKQfDOMfvGc0GoFhZfx6IQ3iQVqQuiCsU4u8TGnCsjadUePht+Hu0VDiYTfpfi6TNVO0FtTybDIUIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/kdFe6iMHAXLDEl9uLfXXhjQvS9dw4/xA78k8IDBfk=;
 b=pe7QWUqJw8WZEzvZuzm81ioyrz5zhJ3QnqHvWIMYcNdMN13ZcShrksvwIPzUnsGPEjxpiK+Ms3nKqtHu0ryhCQ3rgso+zSvbIBgMhA3HG325nW8r5tXEE6CQTh5FEZiuUR3AR3t48c5bHK45WqSze6HjZXloF+ZL4Yc+wc/aoYo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSOP286MB3970.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2f0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 07:16:12 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.010; Fri, 30 Jan 2026
 07:16:12 +0000
Date: Fri, 30 Jan 2026 16:16:11 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: mani@kernel.org, vkoul@kernel.org, jingoohan1@gmail.com, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] PCI: dwc: Add helper to query integrated dw-edma
 linked-list region
Message-ID: <zqcu3awadvqbtil3vudcmgjyjpku7divrhqyox72k43nfzcoo7@hflaengfjy27>
References: <20260127033420.3460579-1-den@valinux.co.jp>
 <20260127033420.3460579-8-den@valinux.co.jp>
 <aXovtOcilRrkA0Ot@lizhi-Precision-Tower-5810>
 <dpx4s35dqvhp54sloixxsn3qcf3g2k745wieaefdc2svgkbtr6@4vuqgp46czi7>
 <aXrXJbjKiAFXaxOX@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXrXJbjKiAFXaxOX@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYCP286CA0106.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSOP286MB3970:EE_
X-MS-Office365-Filtering-Correlation-Id: 971ea47c-9fc3-4b5b-42fe-08de5fcf7321
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v8V+NcYgwkHgoR0SUiLHmCLAlF8oFJFbRjtxnKrKy9E9e+VPW3aR4xxnNpBB?=
 =?us-ascii?Q?7i3Xr4oS3I61BbG7IedFO0wnntVbLJsoOSvpk6XyGOM2WFN7UrxEeoBLH07C?=
 =?us-ascii?Q?jEpoAQ/rYJ7rp/Is961TA6QN/5dMMSz/Q6XedQQbl2zPCORd2PQSDOuCCv+8?=
 =?us-ascii?Q?tD7lgnBjTpWm6TQLJezWf+beemF3/ayFMpl5Mkf/dbTlBaa4Np6icjmpo54o?=
 =?us-ascii?Q?iktGsnG57jQOIGN2CB63gJK0Ms1O7KF+hkosdhOiwsNyavMIlZhpoanSanql?=
 =?us-ascii?Q?Q2AZfUh+wyZjg1W8Gh66XV9VpSb7lvDnUneA/Oqvmk98HVrLFG81cTZyxD1Q?=
 =?us-ascii?Q?yYRYvFaDYAWsJ1u3NTHfi8eHjpTGb0nFpV+s8PMBNYAyc8bJsWksY6GvJ22r?=
 =?us-ascii?Q?HOI6rGZGiaEodQ8AChQ14W7YsQ97KMT4EJK269xJ32QE7EE12VzvLhzjzs8q?=
 =?us-ascii?Q?FsYPDqw09ITIHSjn6INnWleuUO31ynzfSRgztqx6eRSfZd+c/wWnYEEzRjNV?=
 =?us-ascii?Q?9GhRfND3pvvOnb3b4Kt6aztv2XwRZnZnHKbMhtF0piH64KieFPSPS/SMt2u5?=
 =?us-ascii?Q?5r4+AQwdukeA+9IXsTQGjYezwfUJk0ou4Yj0k5SvMWM4forJuTusBR3By+Ej?=
 =?us-ascii?Q?gKpXpfEJcw3w1aCM7EK0MNlWnT1/FZdnPxADuQF5lOEQsje2MX6kaf+54S8u?=
 =?us-ascii?Q?sWv0uw0fH1fwTYgpd2MzCBwBdk+cE+AtFa304o9oLq8hZCGHAcEt2mXnAHK7?=
 =?us-ascii?Q?UmmADZwE1WFR5SNFJwssuNzuMvhwp5FD95bBzat7Y/gwPDPV/5ZHd8JAxltW?=
 =?us-ascii?Q?mQVzL/0O4EDPQP00xfJxBFmmk+6TCfvjUIZrrOtnaCmRdYxOkYBqweAvEWiH?=
 =?us-ascii?Q?zixhhSFZxw4xhCv1xD/amIIMCum+L/aV9GQTUWkdX6cUjpLALFJCYEXYlr+g?=
 =?us-ascii?Q?7jZ97XDGlS8QZ4IEp1Ok/MfU1bsv3xKW0l+q8YnL2TnLkTY4nCevwkKCzc8x?=
 =?us-ascii?Q?9IEoo+pGhBjwqOAXB87QR5/n/MwYMbztf8Yx49rJR7rtMuXA8Sz0sKugkEAe?=
 =?us-ascii?Q?BjceIKCRMfxza6BHPVxpznQhTQF6KXMPLgPtdlnZb8jO0o65L2MglM1psKD0?=
 =?us-ascii?Q?5BUCCTH5NDaZMGHaSh7XiJuKdUwc4KvgX7C3SEMi4zWzRgXQK46YBY+DBB5n?=
 =?us-ascii?Q?h70IBPc820FYeRLqyXItmNJG+Zq8nubLg3oazr++W0XNPXDnMQW/JCS11mNj?=
 =?us-ascii?Q?3ULoA5qFGAZwwKUBp6D4LGqB/R7QqRiY4vnVhZJsiAm3M1sM/bdDVf8SkJEU?=
 =?us-ascii?Q?z8cMf+GAIzBi5uDwFbatPwsQQL/8eytIZ2hd0UQPj6CHON5t9ej6PS1vgKcO?=
 =?us-ascii?Q?TC9httYjWQ1KYCtHhEcGtN0tvIMzZI9X3F4uGnnabYANd5RasFeT/Avj4+zX?=
 =?us-ascii?Q?yB2MmnzKRK/WL3cAOrjy+ofyM2FXDEw/uzHAp6AJCGChWqshp8W3QKJDLSHp?=
 =?us-ascii?Q?2g4EwSV7JoS1urqoOCafAr69K7T5gV+RLcb8/vylNsQPRBbUPB1EgFLOGfGX?=
 =?us-ascii?Q?NP6S3e3JTmTnrS3HuIptzhI9JjzDxrxZi/C38R2b?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m5lFIupF33+f5Q5OS3jTvAYskwAJn4w+axXPJXw6bjGfAAYJa9J6j7qKilnz?=
 =?us-ascii?Q?dem9cuQU43TVitRqmtnYMD0gKTMkmRNNZbxOaUwUCleQDOoR4AByTyPBjp4e?=
 =?us-ascii?Q?4IpysZb1J5ncmsdonSqX121fI1VXBBeIh9h7JNfu1tEGV8llkRPclY1dRlcY?=
 =?us-ascii?Q?zmG2FBlv+mE2Ml1Ed5YUrJBrRkMb7JJGD7G80//uQoL7xJfBO9j3jyBsjhTe?=
 =?us-ascii?Q?fSonh7acUky0yqDe7+4oWLKWerxn8v70OUKMllcM188+fTc/Y7LUmDSVzIi4?=
 =?us-ascii?Q?4A0+R7Eh0yLWzVS8X14hSU/8ZOhmb25up936ra1J9QWddGodFAbHdBXVegU/?=
 =?us-ascii?Q?Wh/6CXD8Ial9VO1n7iA4oFveJ2SZsY2H5C1FnlkW80sOHCeUTXDoOk1U8nN+?=
 =?us-ascii?Q?t353qtNZrL4XXj/mCGbuD2YbpPYI3KbFZF4xGWA1PVx4uYJxXIMlNf68kQS1?=
 =?us-ascii?Q?iUOSJInHxDYwDkGUwLMXLwb3l07mPTU98y9c/gh4KU1UYVULCreri2Epi2+2?=
 =?us-ascii?Q?5Fh0uoIgOtuhBd8M6QnnI1yt7n6okDuKpdTVzKok8bT79S/9HrS/DSnrL7RA?=
 =?us-ascii?Q?TYzUzcwU4L0sqEbXTYIjP86QBYIDHQUCUM/fxW/DILM8WSo8pWLKvCA1q6yq?=
 =?us-ascii?Q?QB1SeVOVNoekg0EQlIgImHMVCf1TpOlY69n7ChZ68EFxu3H2KwdOVU3hkwch?=
 =?us-ascii?Q?PLMjGWQfeG8xw04FOud29xUbxYU293rT512NfwjTbsFm8rFEnpO+E28eOnd5?=
 =?us-ascii?Q?3JhwwLrPIgXhdWtFmEyFCL+JG+dhQXy9z+Zx/oWXWUAgC5kVmpDpLZo54WTa?=
 =?us-ascii?Q?CWCkp+4dzubqfWWlDZgqBx7Jk4xnt55ansHBqCCevae7zbTtTsYAvLN7G0fX?=
 =?us-ascii?Q?ZSi5AxttgjE+wNT6P2BUp+HOApGoI/Inj7T83DkAX7UqM99/2OzXx7c9wIA+?=
 =?us-ascii?Q?KAqEo3bOvb8MjmsMuH4VkA3tgSIcSMqYprTKkBFvLXjNHST3JAzjJGv8B72l?=
 =?us-ascii?Q?AcM9AzMbMBYl20kJ5yxXiesFZBXNzKMQTSNxiQg1PbuKgyStDL1mcuhGLBtQ?=
 =?us-ascii?Q?TfeQ7Z40HYXmCe62XjQ2aR+vls29iTxbBnexLQlJH5L2Ceg6b1BC9N/cQNSW?=
 =?us-ascii?Q?MO6m1xn1oF8wGmA5VFLIQCJUcBMD9hQAqpEYS+FEQK1JCWegEl/tb7qT10Ym?=
 =?us-ascii?Q?C/SECre7pugYnbI2XlfZUsKUFykaHoui987Kb0cvO6snaF0tErOxP5cEK5HS?=
 =?us-ascii?Q?f/x2YMQWk/qogKNOn+i4ElYHdkQkAm5lVjpvoXDK1s2RNCXLWVgq2B8z+r5G?=
 =?us-ascii?Q?rD/vfG5m0ibpH3kjfo3alpv2Qs0K4vqj7IL7jckDg/phOKbaG+p1daQ2LkSF?=
 =?us-ascii?Q?d6zAIxdCJ+VL2VwQQZ7iVdaPq4I0qsBIPwbneq+wjvZwWBKmh2A/5Gc4l2f1?=
 =?us-ascii?Q?HeezjhC3toKcbz+mFDwgUEhg1a+04X3s/htIQRsD92JpqpWFy+7DWHJR7onj?=
 =?us-ascii?Q?UnKi/fe5SRZ53gAYmRprLKHAYZUT8A5MVCZCYDABpdyDxGlBGTCdufyZ39eF?=
 =?us-ascii?Q?y7BA4hJAFUV2xqKII8Hty0aGL4Vmt0a6ANIbSBoYvyHwVb8WIsIzteozWNiC?=
 =?us-ascii?Q?sF+zJCZgmQg+2d2MN4ZGY8KgUJ7D2h4+Bj3NdYmBdVIIm2wRsJBPWuIhRj0l?=
 =?us-ascii?Q?0OubR3ykhP+g9lWCHDkL/76oq6SXegJGUKQEshAscteRnUlQlG6hnrUX3UXS?=
 =?us-ascii?Q?VK4tRQY4eAm92peyO5tx+VrXCeUyf9bIcxpZ0zBya1Lfaqo5CKbA?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 971ea47c-9fc3-4b5b-42fe-08de5fcf7321
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 07:16:12.8822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7ikRScui2RpV8Dpn3ZhzMCtrf1/LywTW5D7ri+Oxo+/DyWLA1QiwLXhEnDUBtWINUoTHT10l9CKJVwwy0UfrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOP286MB3970
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8591-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 673C6B7D2E
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 10:42:29PM -0500, Frank Li wrote:
> On Thu, Jan 29, 2026 at 01:25:30AM +0900, Koichiro Den wrote:
> > On Wed, Jan 28, 2026 at 10:48:04AM -0500, Frank Li wrote:
> > > On Tue, Jan 27, 2026 at 12:34:20PM +0900, Koichiro Den wrote:
> > > > Some DesignWare PCIe endpoint controllers integrate a DesignWare eDMA
> > > > instance and allocate per-channel linked-list (LL) regions. Remote eDMA
> > > > providers may need to expose those LL regions to the host so it can
> > > > build descriptors against the remote view.
> > > >
> > > > Export dwc_pcie_edma_get_ll_region() to allow higher-level code to query
> > > > the LL region (base/size) for a given EPC, transfer direction
> > > > (DMA_DEV_TO_MEM / DMA_MEM_TO_DEV) and hardware channel identifier. The
> > > > helper maps the request to the appropriate read/write LL region
> > > > depending on whether the integrated eDMA is the local or the remote
> > > > view.
> > > >
> > > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > > ---
> > > >  drivers/pci/controller/dwc/pcie-designware.c | 45 ++++++++++++++++++++
> > > >  include/linux/pcie-dwc-edma.h                | 33 ++++++++++++++
> > > >  2 files changed, 78 insertions(+)
> > > >
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > > index bbaeecce199a..e8617873e832 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > > @@ -1369,3 +1369,48 @@ int dwc_pcie_edma_get_reg_window(struct pci_epc *epc, phys_addr_t *phys,
> > > >  	return 0;
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(dwc_pcie_edma_get_reg_window);
> > > > +
> > > > +int dwc_pcie_edma_get_ll_region(struct pci_epc *epc,
> > > > +				enum dma_transfer_direction dir, int hw_id,
> > > > +				struct dw_edma_region *region)
> > >
> > > These APIs need an user, A simple method is that add one test case in
> > > pci-epf-test.
> >
> > Thanks for the feedback.
> >
> > I'm unsure whether adding DesignWare-specific coverage to pci-epf-test
> > would be acceptable. I'd appreciate your guidance on the preferred
> > approach.
> >
> > One possible direction I had in mind is to keep pci-epf-test.c generic and
> 
> Add a EPC/EPF API, so dynatmic check if support DMA region or other feature.

Thank you for the comment.

Ok, I have drafted an API ([1] below).

One thing I'm unsure about is how far the pci-epf-test validation should
go. Since the API (pci_epc_get_remote_resources() in [1]) is generic and
only returns a list of (type, phys_addr, size, and type-specific fields), a
fully end-to-end validation (i.e. "are these resources actually usable from
the host?") would require controller-specific (DW-eDMA-specific) knowledge
and also depends on how those resources are exposed (e.g. for a eDMA LL
region, it may be sufficient to inform the host of EP-local address, while
the eDMA register block would need to be fully exposed via BAR mapping).

Do you think a "smoke test" would be sufficient for now (e.g. testing
whether the new API returns a sane / well-formed list of resources), or are
you expecting the test to actually program the DMA eingine from the host?
Personally, I think the former would suffice, since the latter would be
very close to re-implementing the real user (e.g. ntb_dw_edma [2]) itself.

[1]:

diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index c021c7af175f..4cb5e634daba 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -61,6 +61,35 @@ struct pci_epc_map {
        void __iomem    *virt_addr;
 };

+/**
+ * enum pci_epc_remote_resource_type - remote resource type identifiers
+ */
+enum pci_epc_remote_resource_type {
+       PCI_EPC_RR_DMA_CTRL_MMIO,
+       PCI_EPC_RR_DMA_CHAN_DESC,
+};
+
+/**
+ * struct pci_epc_remote_resource - a physical resource that can be exposed
+ * @type:      resource type, see enum pci_epc_remote_resource_type
+ * @phys_addr: physical base address of the resource
+ * @size:      size of the resource in bytes
+ * @u:         type-specific metadata
+ */
+struct pci_epc_remote_resource {
+       enum pci_epc_remote_resource_type type;
+       phys_addr_t phys_addr;
+       size_t size;
+
+       union {
+               /* PCI_EPC_RR_DMA_CHAN_DESC */
+               struct {
+                       u16 hw_chan_id;
+                       bool ep2rc;
+               } dma_chan_desc;
+       } u;
+};
+
 /**
  * struct pci_epc_ops - set of function pointers for performing EPC operations
  * @write_header: ops to populate configuration space header
@@ -84,6 +113,8 @@ struct pci_epc_map {
  * @start: ops to start the PCI link
  * @stop: ops to stop the PCI link
  * @get_features: ops to get the features supported by the EPC
+ * @get_remote_resources: ops to retrieve controller-owned resources that can be
+ *                       exposed to the remote host (optional)
  * @owner: the module owner containing the ops
  */
 struct pci_epc_ops {
@@ -115,6 +146,9 @@ struct pci_epc_ops {
        void    (*stop)(struct pci_epc *epc);
        const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
                                                       u8 func_no, u8 vfunc_no);
+       int     (*get_remote_resources)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+                                       struct pci_epc_remote_resource *resources,
+                                       int num_resources);
        struct module *owner;
 };

@@ -309,6 +343,9 @@ int pci_epc_start(struct pci_epc *epc);
 void pci_epc_stop(struct pci_epc *epc);
 const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
                                                    u8 func_no, u8 vfunc_no);
+int pci_epc_get_remote_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+                                struct pci_epc_remote_resource *resources,
+                                int num_resources);
 enum pci_barno
 pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
 enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features

---8<---

Notes:
* The naming ("pci_epc_get_remote_resources") is still TBD, but the intent
  is to return everything needed to support remote use of an EPC-integraed
  DMA engine.
* With this API, [PATCH v2 1/7] and [PATCH v2 2/7] are no longer needed,
  since API caller does not need to know the low-level DMA channel id
  (hw_id).

[2] https://lore.kernel.org/all/20260118135440.1958279-26-den@valinux.co.jp/

Thanks for the review,
Koichiro

> 
> Frank
> 
> > add an optional DesignWare-specific extension, selected via Kconfig, to
> > exercise these helpers. Likewise on the host side
> > (drivers/misc/pci_endpoint_test.c and kselftest pci_endpoint_test.c).
> >
> > Koichiro
> >
> > >
> > > Frank
> > >
> > > > +{
> > > > +	struct dw_edma_chip *chip;
> > > > +	struct dw_pcie_ep *ep;
> > > > +	struct dw_pcie *pci;
> > > > +	bool dir_read;
> > > > +
> > > > +	if (!epc || !region)
> > > > +		return -EINVAL;
> > > > +	if (dir != DMA_DEV_TO_MEM && dir != DMA_MEM_TO_DEV)
> > > > +		return -EINVAL;
> > > > +	if (hw_id < 0)
> > > > +		return -EINVAL;
> > > > +
> > > > +	ep = epc_get_drvdata(epc);
> > > > +	if (!ep)
> > > > +		return -ENODEV;
> > > > +
> > > > +	pci = to_dw_pcie_from_ep(ep);
> > > > +	chip = &pci->edma;
> > > > +
> > > > +	if (!chip->dev)
> > > > +		return -ENODEV;
> > > > +
> > > > +	if (chip->flags & DW_EDMA_CHIP_LOCAL)
> > > > +		dir_read = (dir == DMA_DEV_TO_MEM);
> > > > +	else
> > > > +		dir_read = (dir == DMA_MEM_TO_DEV);
> > > > +
> > > > +	if (dir_read) {
> > > > +		if (hw_id >= chip->ll_rd_cnt)
> > > > +			return -EINVAL;
> > > > +		*region = chip->ll_region_rd[hw_id];
> > > > +	} else {
> > > > +		if (hw_id >= chip->ll_wr_cnt)
> > > > +			return -EINVAL;
> > > > +		*region = chip->ll_region_wr[hw_id];
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(dwc_pcie_edma_get_ll_region);
> > > > diff --git a/include/linux/pcie-dwc-edma.h b/include/linux/pcie-dwc-edma.h
> > > > index a5b0595603f4..36afb4df1998 100644
> > > > --- a/include/linux/pcie-dwc-edma.h
> > > > +++ b/include/linux/pcie-dwc-edma.h
> > > > @@ -6,6 +6,8 @@
> > > >  #ifndef LINUX_PCIE_DWC_EDMA_H
> > > >  #define LINUX_PCIE_DWC_EDMA_H
> > > >
> > > > +#include <linux/dma/edma.h>
> > > > +#include <linux/dmaengine.h>
> > > >  #include <linux/errno.h>
> > > >  #include <linux/kconfig.h>
> > > >  #include <linux/pci-epc.h>
> > > > @@ -27,6 +29,29 @@
> > > >   */
> > > >  int dwc_pcie_edma_get_reg_window(struct pci_epc *epc, phys_addr_t *phys,
> > > >  				 resource_size_t *sz);
> > > > +
> > > > +/**
> > > > + * dwc_pcie_edma_get_ll_region() - get linked-list (LL) region for a HW channel
> > > > + * @epc:    EPC device associated with the integrated eDMA instance
> > > > + * @dir:    DMA transfer direction (%DMA_DEV_TO_MEM or %DMA_MEM_TO_DEV)
> > > > + * @hw_id:  hardware channel identifier (equals to dw_edma_chan.id)
> > > > + * @region: pointer to a region descriptor to fill in
> > > > + *
> > > > + * Some integrated DesignWare eDMA instances allocate per-channel linked-list
> > > > + * (LL) regions for descriptor storage. This helper returns the LL region
> > > > + * corresponding to @dir and @hw_id.
> > > > + *
> > > > + * The mapping between @dir and the underlying eDMA read/write LL region
> > > > + * depends on whether the integrated eDMA instance represents a local or a
> > > > + * remote view.
> > > > + *
> > > > + * Return: 0 on success, -EINVAL on invalid arguments (including out-of-range
> > > > + *         @hw_id), or -ENODEV if the integrated eDMA instance is not present
> > > > + *         or not initialized.
> > > > + */
> > > > +int dwc_pcie_edma_get_ll_region(struct pci_epc *epc,
> > > > +				enum dma_transfer_direction dir, int hw_id,
> > > > +				struct dw_edma_region *region);
> > > >  #else
> > > >  static inline int
> > > >  dwc_pcie_edma_get_reg_window(struct pci_epc *epc, phys_addr_t *phys,
> > > > @@ -34,6 +59,14 @@ dwc_pcie_edma_get_reg_window(struct pci_epc *epc, phys_addr_t *phys,
> > > >  {
> > > >  	return -ENODEV;
> > > >  }
> > > > +
> > > > +static inline int
> > > > +dwc_pcie_edma_get_ll_region(struct pci_epc *epc,
> > > > +			    enum dma_transfer_direction dir, int hw_id,
> > > > +			    struct dw_edma_region *region)
> > > > +{
> > > > +	return -ENODEV;
> > > > +}
> > > >  #endif /* CONFIG_PCIE_DW */
> > > >
> > > >  #endif /* LINUX_PCIE_DWC_EDMA_H */
> > > > --
> > > > 2.51.0
> > > >

