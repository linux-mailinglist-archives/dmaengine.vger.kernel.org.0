Return-Path: <dmaengine+bounces-8670-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FwpHfjMgGl3AgMAu9opvQ
	(envelope-from <dmaengine+bounces-8670-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Feb 2026 17:12:40 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14640CEBE3
	for <lists+dmaengine@lfdr.de>; Mon, 02 Feb 2026 17:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AF804302AD4B
	for <lists+dmaengine@lfdr.de>; Mon,  2 Feb 2026 16:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0361837C0F9;
	Mon,  2 Feb 2026 16:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eMdQN85j"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013012.outbound.protection.outlook.com [52.101.83.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3299C3793CF;
	Mon,  2 Feb 2026 16:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770048624; cv=fail; b=a+94XHOthf/XAIHKj0miX7NaozKWiX5pPAXg2tn09Q7wwc2a6igCQyNFKhXCfni/ZvYaF0b1ZVjNmcckCEdK7XZ9VGwDdH87/FCjJr2k98GbblF3iyUfHTPgF4Y4w2aD9+5cxnLx95n8G5TWcYatU9/FtCqT710drH+Ylw3vZsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770048624; c=relaxed/simple;
	bh=8wXTbS71l6lQKYPOtD/wC9ybgh8avcv8FDAiHwMKzs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LSjDfMJRUk7dBZyRYikBy4XgFh9tWHMEOLOUqJutwb9EaS69VaIzHmXYYVIgbjIeuVCELnCmp282840WoQJwflNreVc6cOOKStmK3PywsvJX+IxnqwmSMHP3HEWnwr/aaclmEWXd8Oe8jIdhs4iLsooPvddU0XWd3yoj+7boLm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eMdQN85j; arc=fail smtp.client-ip=52.101.83.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iagpljmivVVkFUOvewkyzJmoTf96LZoig4Bt2ZEFgdu2ttD6Fuo2uy685l2L+VXNLbID/Swao8YTg+hvkaPE89/q2yzLO4/br/cYpgXORgy54u+0nAAqkgBhBPDOcjZbkZ2WKRcepDPRn3RoMuZigsHYX4FnpH4ZxsBJKntzj4T8gPvKg/YOl3/gJv461gNPisavrYqPAOg1hulyr7WUQJHkALPolnJ0d7YRoPtO4X1FLuqn5ISe9gQk5ZsEt+avu8CBw/266ogoWEZ/nZGB5nLmPahiNGkEua4ghbZV1nNl0R9HIBtmQW5HoSU7tp5MX5k+ivEES2lXFwuzSm3qlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JU5PwbTH0SHXgbxJs/zbGHjTJXWwPM7IVM/LpiiAldY=;
 b=J8rdOgG1sUM9v2vAleiYDhWT+GvQkJUb+PhoRlWZp0XaIximw4td1BhQcb8M6v3RyyW97rD8Zb398TplLFMO8pnZ2OtK6sSaURdleERyEm/r6PbhyfpoTPWbT7gzZvMfGJwuBapM7331rh128X5O6qRB3rhysZklTvg6sRgCTaChgeaTMcn/aTo/iU6l2AkNNaKxnKbhmtcPdKvckVwb75kknE6oZwavr5K0Ad/Gtgg4VGgkfxeGBYiJTIoM5aQkLGKRmcHBpbFkJRo8qmkY0bk67tb4z6PcTz2zGvXRToby+kQdejXTcaLc2GrWVs7ew55Hd/cPDHcIWwmbCGQAAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JU5PwbTH0SHXgbxJs/zbGHjTJXWwPM7IVM/LpiiAldY=;
 b=eMdQN85jqTbC6Z4dEtaM4tHZRKHmMn7ubdQWAA6BujcMAN/+mTipAzFwC5mCkf50OOikTd6ORzviKYD21xAGvqaZxqUo5zIAKp4YmchRosPs0DfDIc8K+Xp8ojbyxhxwrvq6PI4P8ZGOflKlxA3emfSpc6cEzV6sSXbXkneHrjdPiTOB/kjcppaLHP2Jz18rR8okyx8j8eptNI28aumHqUhswODLIIEJZmNAvfHqXurmZXSD3plEjM/6/0Y/sVeWHZtzFyTeFd/0TqtRDB2trObQGNCTeDoVK2sOFS6noTOjFUrntN+6dvMXpL58LABCs7YL8kFlcRUBDabGlVa+Nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DB9PR04MB8314.eurprd04.prod.outlook.com (2603:10a6:10:249::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 16:10:19 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 16:10:17 +0000
Date: Mon, 2 Feb 2026 11:10:08 -0500
From: Frank Li <Frank.li@nxp.com>
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dma: amlogic: Add general DMA driver for A9
Message-ID: <aYDMYPwNM9WnTl2u@lizhi-Precision-Tower-5810>
References: <20260127-amlogic-dma-v2-0-4525d327d74d@amlogic.com>
 <20260127-amlogic-dma-v2-2-4525d327d74d@amlogic.com>
 <aXuhOZICKEHNQ3GP@lizhi-Precision-Tower-5810>
 <260d0d7d-4324-4fd6-b12d-50ffeaa82114@amlogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <260d0d7d-4324-4fd6-b12d-50ffeaa82114@amlogic.com>
X-ClientProxiedBy: PH7P223CA0006.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::27) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DB9PR04MB8314:EE_
X-MS-Office365-Filtering-Correlation-Id: 85c26ba2-c33b-406f-a559-08de62758d99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QaBYibaLtU0VrpR5Kzy3x7dZbuMwhDMJo91PZjNLvX4yXnmGC8DnemZBi67R?=
 =?us-ascii?Q?qxWe28IFObW8zs7e0VH8JReYe5dyjLNcvW5hL+XzL0C95ofOHVXcVJUlHanv?=
 =?us-ascii?Q?Ptel0D8Rg7TQkryc1QFh/rJc5f/jy7QNYYe3Xs36fOTgrwqJijmg3AIjDE8m?=
 =?us-ascii?Q?jVB6HuM1HyPAVTEHO74GLH45SVROPUQtzD5yzSFdNQ8BQxjNjTdwAeHNL2sf?=
 =?us-ascii?Q?K6TcW4SCjto23+0yk0UzSTsH6AHqnbYq/z5z7orAHZZomWgQyXkzTRDFG7wj?=
 =?us-ascii?Q?vjnysvQzfHNMST2XA+3Ju4lr2NUdnuPbD+TQ8H/B/oiBmj6CKycZ5yrH84UC?=
 =?us-ascii?Q?mVJgFeP2JKr0JQJ4kHiDUOea+MNHMnI+6FnM13zjL5IPK3hQv8TOmZDZTPT2?=
 =?us-ascii?Q?UH3XWRgfaFENqD2/uNKRj4aAte0J6S8JN0BuUZ5h20cXardINSmz+clwSjLz?=
 =?us-ascii?Q?1f8NrvsFKtcLpVQ9zywT5TBhmheZf7hsEqLe1vbGY5mL4KGeu+JTZtsUAzv4?=
 =?us-ascii?Q?lXgJpPOiurTp/adLjzS529fnthhhw7mfSVEXL9e/OTQ4nNNQxoqxARN6ThRn?=
 =?us-ascii?Q?mleZjVyHlVxfJ06JRO4xoyOhC45GfbIVxxJFTgoRHnP6MoHKlbyWz6i1gOKU?=
 =?us-ascii?Q?OvT26nKh24Wdz/P8etgCZiC4ejUP4vGozfueKRf/HrGe5+HdhfxRC687/IDH?=
 =?us-ascii?Q?OskVyN5E24K9Cox94ocjgxH7+r4sG1dc6Q7FuJzlDlWtyhOugoNjf7aKxXQh?=
 =?us-ascii?Q?6ESircrzqYhkNAjm9V1H1Wkbj2snnerAZ6S5Qr9ghgGcKzvhWjrulKIp7hhh?=
 =?us-ascii?Q?DzwyQK/WZMlPsqIViVs+f2rTVwCpaw+rYLTglEBkFnpmhHitWDBadwnTAOIO?=
 =?us-ascii?Q?H2vf9jurB8uxltlUlazwhpGw/kWzu2BeVVmI+YtOOIJi1cQhZSF3sHLBMpgj?=
 =?us-ascii?Q?K6QA9NHKHzjs+/IGd+PXjwwhrjwuHslEPQ9Ln1dtPotvRVY8lzMx43qT8syS?=
 =?us-ascii?Q?Le6JMpMs3liQ1iXELkmyb6izOdI8xi9drmijzIKM7P91nUWXrZAs7MQD/ITf?=
 =?us-ascii?Q?knGbK2SlEi1R3/LNSrId6P4XfBvNjkCxKxBWX3986PkojhYzq11Nn9dXMDfB?=
 =?us-ascii?Q?RdRstc9XsGgd4WzAV3IBEfVVcCJQonBJSri3q9q25GY3YOpMsOOrie2AwEAx?=
 =?us-ascii?Q?QxG27Knm5MKlkLauanTs6nxGvyj1Sc4VlAMngU3WV654WcYqKYUgS61gbI8F?=
 =?us-ascii?Q?3XjpsU1jNPq98+YV5qrFkDD8qFVlmMGoTKQRwzXi1zzYeRlZi5u5SWnq1NOb?=
 =?us-ascii?Q?x5iqah+AqYS+lCGXJTyn6UV9Ij0UXRjaegGJkw5vn4B40lgYZYav7+KFSulj?=
 =?us-ascii?Q?Mp45euHGR6PausWaJsm/s94CkhLmF8UUR7NkV8EEDXb71wrZ5qnbRtnsyPiD?=
 =?us-ascii?Q?09bu1of6jrU0bsEHl29ey0PTJt7nD4jSKumc07UK8qEeHnc4auYFhiYCV2NC?=
 =?us-ascii?Q?zOWV0AaxO2wSMN3BMgDF/zmd7+8iSkkJXGt7hYvZn9/fmSnG+iPlHCfZXazf?=
 =?us-ascii?Q?rUuH5F576VZacnU9twWwE7u9m6WRZzVb1XbkeQ19xRXo2dqRbkG7zg9J/9lz?=
 =?us-ascii?Q?Ujcd1+JaMFcQseDW7uscSyI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pintNMZS7bnZH9w7OoMhgaX2UwanLNYxz1O9/S81ozgjG8o7CJUinjjYqM3o?=
 =?us-ascii?Q?/IJhbssveZRIdictiqMhhgIXcEKCWCGfB3aP5uFeR1EpKTu8RUinQe+DT8lP?=
 =?us-ascii?Q?tySnOEN3+n+366p/eaIsjMzRD1G6teve5V7f1UnVQVqoudkrP8n55bNlWZF7?=
 =?us-ascii?Q?fxf/JtKNhFgv4MPwoBXMQI6lnt/P993C82DY9SKc8hpqgM6WuphnaUXYa9Mh?=
 =?us-ascii?Q?2mFvPJHLNftIouGuEnwQmzilT23QGaaLiWDZPpMz8P4xz0wUw8KtuEne1ih8?=
 =?us-ascii?Q?qxv2hzdtRvnvvifU/YW3+BxuUDZt5bD4bBSnsVLCEV2jSy6d87ZgyHYZWQfC?=
 =?us-ascii?Q?GeQhC4X721DaVrhqOF41TS/suBgy/RhtqSlYEJWbBUUk5HNPFw4rQB0ThhT+?=
 =?us-ascii?Q?0vNedNUJK0WyizIr9G9v8mEfw6qLSN4HMT4AqRn/ciGQp5Lkjv+B3PgWP+kf?=
 =?us-ascii?Q?bcsgr+kJWtltJpoykF65CHdE54xpxwDY+K2NJFl7eVzoTuUEr6DiR+Y8NoBI?=
 =?us-ascii?Q?dprp08uf7EJSqtmcZUH7lFcMwSnCmfZsbwPqkL1eYDZ+4vguGvqep2IUCRAH?=
 =?us-ascii?Q?As0GfeVrRDYZKK4bATgWcslMiFG7QGiRieFnq7da7AFVu4Z2PDdphxsYBs/r?=
 =?us-ascii?Q?93FRIf3J9RWHSIoVt3dKLHEBvo+gbQFdy6W1U2tkcGJvNxH8f+ww9dxb7xi8?=
 =?us-ascii?Q?Y0q9fKmseo4KpOXB0Gv4cldvoTKBK+G3GajAoDRNyk3FjFh9/QjoJUGiUndd?=
 =?us-ascii?Q?/xLhaAy4eUWfXCWNxjm5micEBRcdLN2txexKmh9Uey8KmI5RXmvf/EWpCWkH?=
 =?us-ascii?Q?hvYWoZFumROeWJCtc1UXhCbD8iJ02i25BE5VLmGFYr2XbgLHEWpEM7r417U2?=
 =?us-ascii?Q?rZCUHDPLefKPH8HJquDnKHYGiqX7+t/nqo8lbGXyLN0zd6MSTe/S3bzK4XhQ?=
 =?us-ascii?Q?tpjbVKUD7rcMCOdIJKazmpXD6KuklVLB0BhGzPwyDjzrKaQCoNzXxr8BLRWq?=
 =?us-ascii?Q?QghZxnnrRw2I4jydUtd939pxhVouUVqUpc7RT3TLH+HZslBXdgsd/inqlumJ?=
 =?us-ascii?Q?2YByZjGUD8J1FyHXQW78L2l597DLvAjKxapEjGNPvuml4XhNw+/sILi2Hu7e?=
 =?us-ascii?Q?z1RPUxe99DozXVC/J4Uu2PzyCi6PZGO8iZuJr5gaXq00y+bjbZ4c/yneQ02O?=
 =?us-ascii?Q?/Ff2w+LoLflyzSPG/29ySJQA+l/kOxhVCLUT+xd9btVwDfYaFnBK0QQpNvhC?=
 =?us-ascii?Q?ka027FMLO1bAVHp4/I1BIWaRT2llC7CDg8GB4hCkXyr/V3vd3zxwdu7edwi9?=
 =?us-ascii?Q?ti6gT5l2Y9TrwCX8uPyRWT0TEbJRUG+UFqU0CjAv2SM9/uKlAzshJBlem1ds?=
 =?us-ascii?Q?UNglLprHhgPPBMMltRdQCeqzurLntVLG5xdQySWP0fzUM9HMI0sys0WUZJHm?=
 =?us-ascii?Q?FETwtfamqzYYbuXE8v4eKlTjgj4Wru0+BCG+k7LlVaLUswDjWffdEFyh/NQs?=
 =?us-ascii?Q?2Q3Q/9uB1RK9J19G7sTaiPCGs7o332YQ1WL3Lk4Xz3n14TTWx4+2z2WFNZYv?=
 =?us-ascii?Q?zb/8vAP04AAZBsn0RSvkwuS3vMzjbNualoQIVwfa4o6rfx0IRIzbZrW7I37i?=
 =?us-ascii?Q?T5YPg8HkMaJ0HSM2goBmIu+yBzcewNmpBHmFjWCUq3bcrax/Sf7cl6qX/bQI?=
 =?us-ascii?Q?ZLDoXhV+QLjr6Z0B1SSxOS2H+dV3svRtwYEMZiBR4QfQSa/h?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c26ba2-c33b-406f-a559-08de62758d99
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 16:10:16.8770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1MzNWGnM7MNVS5JgPp3mRmVCSd0Wb8T8qD9FlDGjrR6AMvBcgNA14NVbGtTpMo2yTqidOzNUag2tgo1QPN5dhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8314
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8670-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	REDIRECTOR_URL(0.00)[aka.ms];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,aka.ms:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 14640CEBE3
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 05:23:13PM +0800, Xianwei Zhao wrote:
> Hi Frank,
>    Thanks for your reply.
>
> On 2026/1/30 02:04, Frank Li wrote:
> > [You don't often get email from frank.li@nxp.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
>
> Will do.
>

Needn't this next time to save reader time. Just leave part, which need
discussion.

> > > +
...
> > > +             /* set dma address and len  to sglink*/
> > > +             sg_link->address = sg->dma_address;
> > > +             sg_link->ctl = FIELD_PREP(LINK_LEN, sg_dma_len(sg));
> > > +
> > > +             aml_chan->data_len += sg_dma_len(sg);
> > > +     }
> > > +     aml_chan->sg_link_cnt = idx;
> > > +
> > > +     return &aml_chan->desc;
> >
> > Here have problems, if caller
> >
> >          a = dmaengine_prep_slave_sg();
> >          ...
> >          b = dmaengine_prep_slave_sg();
> >
> >          submit(a); submit(b);
> >
> > API don't limit that prep_slave_sg() must follow submit().
> >
>
> Our DMA module uses a dedicated DMA channel per device and supports
> scatter-gather mode.
>
> In function "prep_slave_sg" , data list has been placed in the hardware
> executable queue,
> and the "submit" do nothing but assign cookies to prevent function
> dma_async_is_tx_complete called error.

Vnod can provide more comments. but according to my options, you should
not have such assumption. If one driver use dma provider 1 work, some daysi
later, switch to provider 2, it fail to work slience.

DMA doc already define API and hehavors, it'd better to follow it.

>
> When device_issue_pending is called, all data list will be processed.
>
> > > +}
> > > +
...
> > > +static void aml_dma_enable_chan(struct dma_chan *chan)
> > > +{
> > > +     struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
> > > +     struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
> > > +     struct aml_dma_sg_link *sg_link;
> > > +     int chan_id = aml_chan->chan_id;
> > > +     int idx = aml_chan->sg_link_cnt - 1;
> > > +
> > > +     /* the last sg set eoc flag */
> > > +     sg_link = &aml_chan->sg_link[idx];
> > > +     sg_link->ctl |= LINK_EOC;
> > > +     dma_wmb();
> >
> > why need it? regmap_write() already have dma_wmb();
> >
>
> regmap_write will call wmb() / iowmb(), not dma_wmb.
> So I think it's best to keep it.

It included dma_wmb() in iowmb(), some system use the same implemention for
iowmb to dwm_wmb().

All memory barray require comments.  Redundant dwm will cause others
confuse.

If it doesn't work without dma_wmb(), your wmb() will have bigger problem
in your system, which will be really hard to debug.

Frank

>
> > Frank
> > > +     if (aml_chan->direction == DMA_MEM_TO_DEV) {
> > > +             regmap_write(aml_dma->regmap, aml_chan->reg_offs + RCH_ADDR,
> > > +                          aml_chan->sg_link_phys);
> > > +             regmap_write(aml_dma->regmap, aml_chan->reg_offs + RCH_LEN, aml_chan->data_len);
> > > +             regmap_update_bits(aml_dma->regmap, RCH_INT_MASK, BIT(chan_id), 0);
> > > +             /* for rch (tx) need set cfg 0 to trigger start */
> > > +             regmap_write(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, 0);
> > > +     } else if (aml_chan->direction == DMA_DEV_TO_MEM) {
> > > +             regmap_write(aml_dma->regmap, aml_chan->reg_offs + WCH_ADDR,
> > > +                          aml_chan->sg_link_phys);
> > > +             regmap_write(aml_dma->regmap, aml_chan->reg_offs + WCH_LEN, aml_chan->data_len);
> > > +             regmap_update_bits(aml_dma->regmap, WCH_INT_MASK, BIT(chan_id), 0);
> > > +     }
> > > +}
...
> > > +
> > > +             .of_match_table = aml_dma_ids,
> > > +     },
> > > +};
> > > +
> > > +module_platform_driver(aml_dma_driver);
> > > +
> > > +MODULE_DESCRIPTION("GENERAL DMA driver for Amlogic");
> > > +MODULE_AUTHOR("Xianwei Zhao <xianwei.zhao@amlogic.com>");
> > > +MODULE_LICENSE("GPL");
> > >
> > > --
> > > 2.52.0
> > >

