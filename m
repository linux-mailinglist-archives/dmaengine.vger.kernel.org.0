Return-Path: <dmaengine+bounces-8584-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAnrKEihe2nOGAIAu9opvQ
	(envelope-from <dmaengine+bounces-8584-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jan 2026 19:04:56 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4894DB35CB
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jan 2026 19:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 71AEC3006162
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jan 2026 18:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377C13563E9;
	Thu, 29 Jan 2026 18:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GnrRZeyU"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010045.outbound.protection.outlook.com [52.101.69.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57F8291C10;
	Thu, 29 Jan 2026 18:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769709894; cv=fail; b=bJ73N9Y7RocPqlPMEDcc6nbAq34bz7XCXPpTfLmrXTf8rsfjjuAlJFRz0vfI0mHk9KP3MvCpK4yuxQJHihNNJb5atsnd6v60RBWkaHkwsKvHlD8hGRYG38cGY1r+hMu13lBwyMDyzQSh3o594wdF+PGs7ur/wNelz8MVWo3GY80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769709894; c=relaxed/simple;
	bh=NUeKgtWo/2ELLOxzPDJo+EKAanzByngEzoTdCaxTYuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YDcqnaXV6tcTdV/uN6pDImF62J6D9Q/vuutyUf6LapELm4v3S2y+xqcFF1r5Qsrhs+NSWP7yHcnVxdMIYX+FiZPVadHkNw68zxHUVJtb5CtqqAsBYRHrXBWDLJ8x6VvKuHkrlhp5CTvAjOOt34WiRnk06H7WDMCWcUXzMqDSOj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GnrRZeyU; arc=fail smtp.client-ip=52.101.69.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gOdAAEyjh5g5MNiiyLKZu4mBgZd+RtY2IysKyF1pIT8SEkrM1QGT3k26yLVZlyZswuPNOlLeUidCQ0BLkrg48CgTG7rf0W9M4XYN4L6P9b2+NUAFk3tOCKs1er1k7nse0nBeh9SdK7asNrS/UVBhE4R066o0gPrb/DRaS04wcvBr3zPHVmreQgojcAEWEj9AVcjV19RogOr7ZpeNVC4aURPridzN/Lqi2uq+hO3tc4WWRWTZMRr7yNcir1fJoUUQw3TTpGb5YvLNkHNflL1Y1mY/bEoxVhH5MAJJve/++sMCWES57S+i3SiLAahoNg3oW2vt1q2x7EsiHqVTLbZ4IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pUQRXtmtNHNO65RsgEDIRkj9XzSF3dL+EL1XFIn3VHk=;
 b=DIuQtK2T8fmjTMWuaPkoeQ9u9uf16XsJK2/IrgOsEa5UQL6bxf9Zl9LKD80hJftJJoYbhUW1HX5j9mZO4pMn2+juMS3rdI4mY7vWJ3FSkuTyGFzamLqhMbHZrzpTUi08IcN3ct10Tm35k9/J2dh1a6XZMtitSYfdQn2zqfo1xA4tGhjNsXsYoYFv7bmx+ro9SFsXvUukJs5UlRP55cLoWGd55b8V/ildlRg0qv9TsN3IFFAoRzCYGD5+E+tOdwkTqNF0Bz64a2FQCTBRrnWw7VqV9A61tpq3Iv5MR66b9WQ/cMM0yMn7qfipQesgmd+lRz4TP1NR84hVEmck7kcdjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUQRXtmtNHNO65RsgEDIRkj9XzSF3dL+EL1XFIn3VHk=;
 b=GnrRZeyUppcyA+SYLpX2KRovETcN7LIj+T6vPKFClXzvr3Ixcghs33eLjwKg/N9JaAtmpyCXwMvo0grjtgwaexCHqumf1zERMqSJAA9HZW8mXiQGOGlbE8VEZ11g8c9OmKb+ENPGP2AnJykdAoFZPU0A2ibeP0HWSvpKQ781+iXblp1sFPI0SNAHxn2BfgLjFm8ZgBbDtMqaSkm1FbXrPZOv5XnHwKL2goaatveNKQ/eh+JxQKK2/PolhjYi3eKlfHpEbJlPBaTdpgue04L3UiLkPMzg8vgReUvZSy8i8JCfOmusUcw+RLZ+rKWOncJGt9xK4WFGLhOeVfscijPKXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by MRWPR04MB12378.eurprd04.prod.outlook.com (2603:10a6:501:84::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.10; Thu, 29 Jan
 2026 18:04:48 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9520.005; Thu, 29 Jan 2026
 18:04:48 +0000
Date: Thu, 29 Jan 2026 13:04:41 -0500
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
Message-ID: <aXuhOZICKEHNQ3GP@lizhi-Precision-Tower-5810>
References: <20260127-amlogic-dma-v2-0-4525d327d74d@amlogic.com>
 <20260127-amlogic-dma-v2-2-4525d327d74d@amlogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127-amlogic-dma-v2-2-4525d327d74d@amlogic.com>
X-ClientProxiedBy: PH8PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::11) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|MRWPR04MB12378:EE_
X-MS-Office365-Filtering-Correlation-Id: 837984c7-2103-4d7a-34a7-08de5f60e3e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gi/NlmT+TCjAqJshYIlCckXUjg8IwZJOdsRsn9zWi1KL7QXMuEn6l2bf3w5c?=
 =?us-ascii?Q?0WVWIqTyqB2DUa8wHellku6RDP+2PWv4MPPE1ac/2LNlfzgjXuxLR1+8tDRd?=
 =?us-ascii?Q?7VYZj1aw5q/SZm4T0WlXDb5E54wQD81LXZF+AL0i5tmIc3CBmS+YaUqEAn6B?=
 =?us-ascii?Q?ytDenaX+kmBm2KXaoZZp6So7D9Ih9Pm4TJiH38vKkDuWJR5q9O+l6Yk4pm8I?=
 =?us-ascii?Q?jQjATTJC9OJDTpRzIs+8H1zm/KKAF/mQFDcDJD6vF6mG8d6V61+D1R6mQXEA?=
 =?us-ascii?Q?720zrPEaWaAKflQJ+V3XTWtO+Vb50NbToTxw2KJngKHKlSEWmbs+j+4S1Yre?=
 =?us-ascii?Q?s1GJbtr3bA4pL7oJmNKY/7hTGMp/LP2imdRMk4LcGs5jkYe5nUm/NFw1oaz1?=
 =?us-ascii?Q?K0ZzFZnk5RVnAWdQRnleJ6LfOJ8Oz0tIxeed3ygI24rH3TrF/xA/hauwp/Id?=
 =?us-ascii?Q?sho3BUKpuMyENZJfygagnZV8UCDN+i+MBM8ZmCmLLBrijVoB6Evzc1ySXBE5?=
 =?us-ascii?Q?oR5oWvOgbmHxvrBjKKLe0ehAV3/uPW5x5Ec2eKM6Hgo21j9I5eXyauOsLhwJ?=
 =?us-ascii?Q?6TdacRJSlXnc5SFbrjrTvG3HvzY1n2xgJWeuCC7dOEIbw1AgXSLtmq/3pRZt?=
 =?us-ascii?Q?ixjw4TormKG4mZ6Tk7y3TmN/iJ6FcrBeMKgAiWtVVqyAmG2IdOT25Ap6Oiiq?=
 =?us-ascii?Q?9JWxQCF23aL5/lOzw3ufQZPt2Ku2wC66P3cUfN1R4sbH9HUH1skUSQ0Xx06z?=
 =?us-ascii?Q?dfmfi2LuuwULIvi3sVUgKSOPiZ73Y2WLa59YkJ9aFR6G7giISUiIbDi9Q+CD?=
 =?us-ascii?Q?q7Mx/qMLRGic3Ss5A89AIewhhE2H1+gmPv+DoZJ8mTp0UeDRraciPxuRbvFL?=
 =?us-ascii?Q?fywjK8WzbDvxoOm9TeT0vOcPCkjDRWHFp5Fd/qvYGAQbYbb4/bqC4IWz0xsW?=
 =?us-ascii?Q?NAARiMr5ngPBy5zBjHIO4xnaNcTh+QWek3mp1prjOHGF3+k9f0Z1/v6B17B+?=
 =?us-ascii?Q?fKK9du+GVypr5Cpu1/j7f75ztV39T8PsE/hKZgygbYuAssWn9XNkRiQqZHns?=
 =?us-ascii?Q?a2rp7p5COuXuenNGCYwomP7y4f63jJy0sWiqLgy8YSKbqPLrN7r3HJqinSDb?=
 =?us-ascii?Q?OldjlT9gTngOLmQgYviYX0QAbJuKZbfHf0LQu9MhD+7CBKH9xkmQnziQhzyy?=
 =?us-ascii?Q?KxlwVPkXV3wgzudYS1jdpLU7GiaZeRpfYnqjiGNJBa35ptW1A8oN6udEFjvW?=
 =?us-ascii?Q?n9RGeBlxRK0hdhzUO3N3tq51pEmv/8HEh+AxSxESdNfT5/XEoY/7/lxazZPo?=
 =?us-ascii?Q?8nSqCwH9uwYGrbraWUx+rNU3f2T9Na94HxCyZ1cWGRIVXchHGbZnjMtUYQja?=
 =?us-ascii?Q?YzfryYgrTvv1imC7vdQvNZrT+n0FdTRtOD5ruy/L9BoEeBTOHm4qB2c0Pthn?=
 =?us-ascii?Q?9Xk8E4mvMNr3fNxUut6Vcmpc1Mhx7DhKnPTXXB1eTAU6YUUQnB4s+SuJFJFi?=
 =?us-ascii?Q?2i4XDSqe6urBReo6T7cYdYYOVCDbPzpz6H4zd9QE9EORHt3dCEOs9hz8/5OR?=
 =?us-ascii?Q?k2kJZNKhJHHyHwVqP9lo2hgNXcPrNSdBjF5lGDwidaL6xWHb/hU9ofFudCU5?=
 =?us-ascii?Q?5Aty6y0uRAoWffod1QVYn08=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IQ36H1weU/kMlQP5XmD93F48NyFyd8wClrq/ulncKYun2SEWjwfLqpuyIQbG?=
 =?us-ascii?Q?piDElRupnt2EqDIDj3OiomjlD5yZy79SA/2h3wS4ED40WZMOCbKUDPtdt9Qg?=
 =?us-ascii?Q?nHOkfW851yEFTsEdjOlmLP0IPzcolXR1oeFuYNmM60vYw9dGHzPTIN0yHsmS?=
 =?us-ascii?Q?PVox35MAvo6TvX5pL8WMhaaI7t0GMxQQYgInOodLxpZTIBdfRT9BubAb2jVZ?=
 =?us-ascii?Q?5C6ZAidB2CMqIHJBdFpXPJKU+XxODGKVryzF16n8pwU7m5BlC1K+HDyyp1z/?=
 =?us-ascii?Q?i+v6WWdMExITA5Fw0qrez6Wn6lh4i7ePFzgiQq44MnOMT3TS9brmUeCyxioL?=
 =?us-ascii?Q?wudGJ+Qmwo7Fg26QAw0gAGtgAFDbbYjez5KDDWuxguU+rc1K5SQRRmcWZDMe?=
 =?us-ascii?Q?/PYROgbUWpqHHTEZbkmk78e6H6eUEMEEd8u0s3dJ/+ZhX9DoZo9Df/WxKbvr?=
 =?us-ascii?Q?t0g57fnD3vXh9IIs0DIh+Zq0WEWdCNmCrJVlTG3gGDdUZAeCyW1wGtdRNT8t?=
 =?us-ascii?Q?SvZO9Z2ZGgGOPsPgpdUULz47EW1tdbtcUXMU0EYP+LZxn5ZIYCUuMkQjUweH?=
 =?us-ascii?Q?El1na7nQ21oIUp/sB44pqn9Fj3HiVUlNP0lCGQp6B9n5Yshkc0jCcM21Algl?=
 =?us-ascii?Q?k7fvzPqU3u9TjtchnNXXq7KHZ0TbiQR8XbEw9RT89a0iTKXhfKDKsSyqLC6Q?=
 =?us-ascii?Q?mdBjLUOZm8jE/AETZmprHt5YNzXDyPohxx3XDxyRLMPHyiFoj0Rpq+l2Ebvx?=
 =?us-ascii?Q?S7PQ1zlScYr8Dv9e2k6aiabrXCqtfMxQXJl4vF2X5kam+XKJ4Ga2VvqsEC71?=
 =?us-ascii?Q?UmvkbeslkBK5+5ZTzkvrDVI3j+GFAFww4lCL68BHLVwS0orPhQrYXxnXuQPa?=
 =?us-ascii?Q?TIuCZFBw9MGZsxDodhpEbzXehNJqTaQ4GtRPjZGiaz3C071BjhcDT6WSR4Fo?=
 =?us-ascii?Q?g2EFl/wcqU2MuX5cl48Vw1xkCxSE8C9wYVM8VhAnNJ0FKfQj30cIN599nEA4?=
 =?us-ascii?Q?+7plQKkyqtQPL7eH9nxiASuaAqLTJmDr0JHP3iyqYjvycILlv7kZjUjgF6ek?=
 =?us-ascii?Q?wDOEkHj4Vec4rvQXCY8Z3B5bNIDRAkKPB6M6g65HPsoGyMEKsPnp/YNhmCFz?=
 =?us-ascii?Q?cWbo2EzTj63lgUVa1lVx8CdcT4L2E1qmHHd4ZXbFWDkdnOVvtl4XZLFePHx7?=
 =?us-ascii?Q?/kjXO/sQ5Qmre88qoWa5sbTvAQD2/pkyOF2HTqzbTt24hxIIUQ/cSm8JASOn?=
 =?us-ascii?Q?/JDUY4f+m348Fpo+79qIcdN3SEKd9aL2aph7TCFMgjCMIG3EADqcOp/EPbi/?=
 =?us-ascii?Q?90hOpCTepvlz5n34DoL4gCJ/C1sfBkUFo6jDb1VVFmn3rxP5U7RQSEmLzhGu?=
 =?us-ascii?Q?N6Ry4pZWEnb/wM6uS/f0h1+mHwHgEubFry0PwjE94fELVgjjNFWJJfb/pCE0?=
 =?us-ascii?Q?0Ag24yW87V/VFAPNIGA9/oqLjs3baxgeKTNLO0+Hl5j/Aaf4Xrg9azdoWpzf?=
 =?us-ascii?Q?UzA34ZftM+w/Oa0O46GPYKlokWrgB4tVBlY/z0vPxgJopO/tXlyWU0jj7Htx?=
 =?us-ascii?Q?EN7wYO+pME/3CoglzQ33lF5V791eposwRsCDy7jqKv7AQ49k06foXM1eAUva?=
 =?us-ascii?Q?XIk0n32NEGgxsaVNDHaq7dfV7KWa8lv3qeIFT6D9724rziPZCF7sBbHC8Wfs?=
 =?us-ascii?Q?ZOEnOAQKhbUUq69JWQ6qYiQLPJjpbAZOzvTj3bov4XAuqRXSUSHM8by0Wobi?=
 =?us-ascii?Q?AT3mQCt+xw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 837984c7-2103-4d7a-34a7-08de5f60e3e7
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 18:04:48.1992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2CF/Jowus1VQQoZU0AEonBYw7sIjkPopZpB5ZutmTTK/6liEKTuQCfzvsnUt/MRxkexaYwqHjnbUFniDSTuJdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB12378
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8584-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amlogic.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4894DB35CB
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 03:27:53AM +0000, Xianwei Zhao wrote:
> Amlogic A9 SoCs include a general-purpose DMA controller that can be used
> by multiple peripherals, such as I2C PIO and I3C. Each peripheral group
> is associated with a dedicated DMA channel in hardware.
>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  drivers/dma/Kconfig       |   9 +
>  drivers/dma/Makefile      |   1 +
>  drivers/dma/amlogic-dma.c | 563 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 573 insertions(+)
>
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 66cda7cc9f7a..8d4578513acf 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -85,6 +85,15 @@ config AMCC_PPC440SPE_ADMA
>  	help
>  	  Enable support for the AMCC PPC440SPe RAID engines.
>
> +config AMLOGIC_DMA
> +	tristate "Amlogic general DMA support"
> +	depends on ARCH_MESON || COMPILE_TEST
> +	select DMA_ENGINE
> +	select REGMAP_MMIO
> +	help
> +	  Enable support for the Amlogic general DMA engines. THis DMA
> +	  controller is used some Amlogic SoCs, such as A9.
> +
>  config APPLE_ADMAC
>  	tristate "Apple ADMAC support"
>  	depends on ARCH_APPLE || COMPILE_TEST
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index a54d7688392b..fc28dade5b69 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_DMATEST) += dmatest.o
>  obj-$(CONFIG_ALTERA_MSGDMA) += altera-msgdma.o
>  obj-$(CONFIG_AMBA_PL08X) += amba-pl08x.o
>  obj-$(CONFIG_AMCC_PPC440SPE_ADMA) += ppc4xx/
> +obj-$(CONFIG_AMLOGIC_DMA) += amlogic-dma.o
>  obj-$(CONFIG_APPLE_ADMAC) += apple-admac.o
>  obj-$(CONFIG_ARM_DMA350) += arm-dma350.o
>  obj-$(CONFIG_AT_HDMAC) += at_hdmac.o
> diff --git a/drivers/dma/amlogic-dma.c b/drivers/dma/amlogic-dma.c
> new file mode 100644
> index 000000000000..dca938638474
> --- /dev/null
> +++ b/drivers/dma/amlogic-dma.c
> @@ -0,0 +1,563 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
> +/*
> + * Copyright (C) 2025 Amlogic, Inc. All rights reserved
> + * Author: Xianwei Zhao <xianwei.zhao@amlogic.com>
> + */
> +
> +#include <linux/init.h>
> +#include <linux/bitfield.h>
> +#include <linux/types.h>
> +#include <linux/mm.h>
> +#include <linux/interrupt.h>
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/slab.h>
> +#include <linux/dmaengine.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_dma.h>
> +#include <linux/list.h>
> +#include <linux/regmap.h>

keep alphabet order

> +#include <asm/irq.h>

Add space line between <> and ""

> +#include "dmaengine.h"
> +
> +#define RCH_REG_BASE		0x0
> +#define WCH_REG_BASE		0x2000
> +/*
> + * Each rch (read from memory) REG offset  Rch_offset 0x0 each channel total 0x40
> + * rch addr = DMA_base + Rch_offset+ chan_id * 0x40 + reg_offset
> + */
> +#define RCH_READY		0x0
> +#define RCH_STATUS		0x4
> +#define RCH_CFG			0x8
> +#define CFG_CLEAR		BIT(25)
> +#define CFG_PAUSE		BIT(26)
> +#define CFG_ENABLE		BIT(27)
> +#define CFG_DONE		BIT(28)
> +#define RCH_ADDR		0xc
> +#define RCH_LEN			0x10
> +#define RCH_RD_LEN		0x14
> +#define RCH_PRT			0x18
> +#define RCH_SYCN_STAT		0x1c
> +#define RCH_ADDR_LOW		0x20
> +#define RCH_ADDR_HIGH		0x24
> +/* if work on 64, it work with RCH_PRT */
> +#define RCH_PTR_HIGH		0x28
> +
> +/*
> + * Each wch (write to memory) REG offset  Wch_offset 0x2000 each channel total 0x40
> + * wch addr = DMA_base + Wch_offset+ chan_id * 0x40 + reg_offset
> + */
> +#define WCH_READY		0x0
> +#define WCH_TOTAL_LEN		0x4
> +#define WCH_CFG			0x8
> +#define WCH_ADDR		0xc
> +#define WCH_LEN			0x10
> +#define WCH_RD_LEN		0x14
> +#define WCH_PRT			0x18
> +#define WCH_CMD_CNT		0x1c
> +#define WCH_ADDR_LOW		0x20
> +#define WCH_ADDR_HIGH		0x24
> +/* if work on 64, it work with RCH_PRT */
> +#define WCH_PTR_HIGH		0x28
> +
> +/* DMA controller reg */
> +#define RCH_INT_MASK		0x1000
> +#define WCH_INT_MASK		0x1004
> +#define CLEAR_W_BATCH		0x1014
> +#define CLEAR_RCH		0x1024
> +#define CLEAR_WCH		0x1028
> +#define RCH_ACTIVE		0x1038
> +#define WCH_ACTIVE		0x103C
> +#define RCH_DONE		0x104C
> +#define WCH_DONE		0x1050
> +#define RCH_ERR			0x1060
> +#define RCH_LEN_ERR		0x1064
> +#define WCH_ERR			0x1068
> +#define DMA_BATCH_END		0x1078
> +#define WCH_EOC_DONE		0x1088
> +#define WDMA_RESP_ERR		0x1098
> +#define UPT_PKT_SYNC		0x10A8
> +#define RCHN_CFG		0x10AC
> +#define WCHN_CFG		0x10B0
> +#define MEM_PD_CFG		0x10B4
> +#define MEM_BUS_CFG		0x10B8
> +#define DMA_GMV_CFG		0x10BC
> +#define DMA_GMR_CFG		0x10C0

Keep hexvalue consistent, low case or up case.

> +
> +#define AML_DMA_TYPE_TX		0
> +#define AML_DMA_TYPE_RX		1
> +#define DMA_MAX_LINK		8
> +#define MAX_CHAN_ID		32
> +#define SG_MAX_LEN		((1 << 27) - 1)

use GEN_MASK

> +
> +struct aml_dma_sg_link {
> +#define LINK_LEN		GENMASK(26, 0)
> +#define LINK_IRQ		BIT(27)
> +#define LINK_EOC		BIT(28)
> +#define LINK_LOOP		BIT(29)
> +#define LINK_ERR		BIT(30)
> +#define LINK_OWNER		BIT(31)
> +	u32 ctl;
> +	u64 address;
> +	u32 revered;
> +} __packed;
> +
> +struct aml_dma_chan {
> +	struct dma_chan			chan;
> +	struct dma_async_tx_descriptor	desc;
> +	struct aml_dma_dev		*aml_dma;
> +	struct aml_dma_sg_link		*sg_link;
> +	dma_addr_t			sg_link_phys;
> +	int				sg_link_cnt;
> +	int				data_len;
> +	enum dma_status			status;
> +	enum dma_transfer_direction	direction;
> +	int				chan_id;
> +	/* reg_base (direction + chan_id) */
> +	int				reg_offs;
> +};
> +
> +struct aml_dma_dev {
> +	struct dma_device		dma_device;
> +	void __iomem			*base;
> +	struct regmap			*regmap;
> +	struct clk			*clk;
> +	int				irq;
> +	struct platform_device		*pdev;
> +	struct aml_dma_chan		*aml_rch[MAX_CHAN_ID];
> +	struct aml_dma_chan		*aml_wch[MAX_CHAN_ID];
> +	unsigned int			chan_nr;
> +	unsigned int			chan_used;
> +	struct aml_dma_chan		aml_chans[]__counted_by(chan_nr);
> +};
> +
> +static struct aml_dma_chan *to_aml_dma_chan(struct dma_chan *chan)
> +{
> +	return container_of(chan, struct aml_dma_chan, chan);
> +}
> +
> +static dma_cookie_t aml_dma_tx_submit(struct dma_async_tx_descriptor *tx)
> +{
> +	return dma_cookie_assign(tx);
> +}
> +
> +static int aml_dma_alloc_chan_resources(struct dma_chan *chan)
> +{
> +	struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
> +	struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
> +
> +	aml_chan->sg_link = dma_alloc_coherent(aml_dma->dma_device.dev,
> +					       sizeof(struct aml_dma_sg_link) * DMA_MAX_LINK,

use size_mul()

> +					       &aml_chan->sg_link_phys, GFP_KERNEL);
> +	if (!aml_chan->sg_link)
> +		return  -ENOMEM;
> +
> +	/* offset is the same RCH_CFG and WCH_CFG */
> +	regmap_update_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_CLEAR, CFG_CLEAR);
> +	aml_chan->status = DMA_COMPLETE;
> +	dma_async_tx_descriptor_init(&aml_chan->desc, chan);
> +	aml_chan->desc.tx_submit = aml_dma_tx_submit;
> +	regmap_update_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_CLEAR, 0);
> +
> +	return 0;
> +}
> +
> +static void aml_dma_free_chan_resources(struct dma_chan *chan)
> +{
> +	struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
> +	struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
> +
> +	aml_chan->status = DMA_COMPLETE;
> +	dma_free_coherent(aml_dma->dma_device.dev,
> +			  sizeof(struct aml_dma_sg_link) * DMA_MAX_LINK,
> +			  aml_chan->sg_link, aml_chan->sg_link_phys);
> +}
> +
> +/* DMA transfer state  update how many data reside it */
> +static enum dma_status aml_dma_tx_status(struct dma_chan *chan,
> +					 dma_cookie_t cookie,
> +					 struct dma_tx_state *txstate)
> +{
> +	struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
> +	struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
> +	u32 residue, done;
> +
> +	regmap_read(aml_dma->regmap, aml_chan->reg_offs + RCH_RD_LEN, &done);
> +	residue = aml_chan->data_len - done;
> +	dma_set_tx_state(txstate, chan->completed_cookie, chan->cookie,
> +			 residue);
> +
> +	return aml_chan->status;
> +}
> +
> +static struct dma_async_tx_descriptor *aml_dma_prep_slave_sg
> +		(struct dma_chan *chan, struct scatterlist *sgl,
> +		unsigned int sg_len, enum dma_transfer_direction direction,
> +		unsigned long flags, void *context)
> +{
> +	struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
> +	struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
> +	struct aml_dma_sg_link *sg_link;
> +	struct scatterlist *sg;
> +	int idx = 0;
> +	u32 reg, chan_id;
> +	u32 i;
> +
> +	if (aml_chan->direction != direction) {
> +		dev_err(aml_dma->dma_device.dev, "direction not support\n");
> +		return NULL;
> +	}
> +
> +	switch (aml_chan->status) {
> +	case DMA_IN_PROGRESS:
> +		/* support multiple prep before pending */
> +		idx = aml_chan->sg_link_cnt;
> +
> +		break;
> +	case DMA_COMPLETE:
> +		aml_chan->data_len = 0;
> +		chan_id = aml_chan->chan_id;
> +		reg = (direction == DMA_DEV_TO_MEM) ? WCH_INT_MASK : RCH_INT_MASK;
> +		regmap_update_bits(aml_dma->regmap, reg, BIT(chan_id), BIT(chan_id));
> +
> +		break;
> +	default:
> +		dev_err(aml_dma->dma_device.dev, "status error\n");
> +		return NULL;
> +	}
> +
> +	if (sg_len + idx > DMA_MAX_LINK) {
> +		dev_err(aml_dma->dma_device.dev,
> +			"maximum number of sg exceeded: %d > %d\n",
> +			sg_len, DMA_MAX_LINK);
> +		aml_chan->status = DMA_ERROR;
> +		return NULL;
> +	}
> +
> +	aml_chan->status = DMA_IN_PROGRESS;
> +
> +	for_each_sg(sgl, sg, sg_len, i) {
> +		if (sg_dma_len(sg) > SG_MAX_LEN) {
> +			dev_err(aml_dma->dma_device.dev,
> +				"maximum bytes exceeded: %d > %d\n",
> +				sg_dma_len(sg), SG_MAX_LEN);
> +			aml_chan->status = DMA_ERROR;
> +			return NULL;
> +		}
> +		sg_link = &aml_chan->sg_link[idx++];
> +		/* set dma address and len  to sglink*/
> +		sg_link->address = sg->dma_address;
> +		sg_link->ctl = FIELD_PREP(LINK_LEN, sg_dma_len(sg));
> +
> +		aml_chan->data_len += sg_dma_len(sg);
> +	}
> +	aml_chan->sg_link_cnt = idx;
> +
> +	return &aml_chan->desc;

Here have problems, if caller

	a = dmaengine_prep_slave_sg();
	...
	b = dmaengine_prep_slave_sg();

	submit(a); submit(b);

API don't limit that prep_slave_sg() must follow submit().

> +}
> +
> +static int aml_dma_pause_chan(struct dma_chan *chan)
> +{
> +	struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
> +	struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
> +
> +	regmap_update_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_PAUSE, CFG_PAUSE);
> +	aml_chan->status = DMA_PAUSED;
> +
> +	return 0;
> +}
> +
> +static int aml_dma_resume_chan(struct dma_chan *chan)
> +{
> +	struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
> +	struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
> +
> +	regmap_update_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_PAUSE, 0);
> +	aml_chan->status = DMA_IN_PROGRESS;
> +
> +	return 0;
> +}
> +
> +static int aml_dma_terminate_all(struct dma_chan *chan)
> +{
> +	struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
> +	struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
> +	int chan_id = aml_chan->chan_id;
> +
> +	aml_dma_pause_chan(chan);
> +	regmap_update_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_CLEAR, CFG_CLEAR);
> +
> +	if (aml_chan->direction == DMA_MEM_TO_DEV)
> +		regmap_update_bits(aml_dma->regmap, RCH_INT_MASK, BIT(chan_id), BIT(chan_id));
> +	else if (aml_chan->direction == DMA_DEV_TO_MEM)
> +		regmap_update_bits(aml_dma->regmap, WCH_INT_MASK, BIT(chan_id), BIT(chan_id));
> +
> +	aml_chan->status = DMA_COMPLETE;
> +
> +	return 0;
> +}
> +
> +static void aml_dma_enable_chan(struct dma_chan *chan)
> +{
> +	struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
> +	struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
> +	struct aml_dma_sg_link *sg_link;
> +	int chan_id = aml_chan->chan_id;
> +	int idx = aml_chan->sg_link_cnt - 1;
> +
> +	/* the last sg set eoc flag */
> +	sg_link = &aml_chan->sg_link[idx];
> +	sg_link->ctl |= LINK_EOC;
> +	dma_wmb();

why need it? regmap_write() already have dma_wmb();

Frank
> +	if (aml_chan->direction == DMA_MEM_TO_DEV) {
> +		regmap_write(aml_dma->regmap, aml_chan->reg_offs + RCH_ADDR,
> +			     aml_chan->sg_link_phys);
> +		regmap_write(aml_dma->regmap, aml_chan->reg_offs + RCH_LEN, aml_chan->data_len);
> +		regmap_update_bits(aml_dma->regmap, RCH_INT_MASK, BIT(chan_id), 0);
> +		/* for rch (tx) need set cfg 0 to trigger start */
> +		regmap_write(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, 0);
> +	} else if (aml_chan->direction == DMA_DEV_TO_MEM) {
> +		regmap_write(aml_dma->regmap, aml_chan->reg_offs + WCH_ADDR,
> +			     aml_chan->sg_link_phys);
> +		regmap_write(aml_dma->regmap, aml_chan->reg_offs + WCH_LEN, aml_chan->data_len);
> +		regmap_update_bits(aml_dma->regmap, WCH_INT_MASK, BIT(chan_id), 0);
> +	}
> +}
> +
> +static irqreturn_t aml_dma_interrupt_handler(int irq, void *dev_id)
> +{
> +	struct aml_dma_dev *aml_dma = dev_id;
> +	struct aml_dma_chan *aml_chan;
> +	u32 done, eoc_done, err, err_l, end;
> +	int i = 0;
> +
> +	/* deal with rch normal complete and error */
> +	regmap_read(aml_dma->regmap, RCH_DONE, &done);
> +	regmap_read(aml_dma->regmap, RCH_ERR, &err);
> +	regmap_read(aml_dma->regmap, RCH_LEN_ERR, &err_l);
> +	err = err | err_l;
> +
> +	done = done | err;
> +
> +	while (done) {
> +		i = ffs(done) - 1;
> +		aml_chan = aml_dma->aml_rch[i];
> +		regmap_write(aml_dma->regmap, CLEAR_RCH, BIT(aml_chan->chan_id));
> +		if (!aml_chan) {
> +			dev_err(aml_dma->dma_device.dev, "idx %d rch not initialized\n", i);
> +			done &= ~BIT(i);
> +			continue;
> +		}
> +		aml_chan->status = (err & (1 << i)) ? DMA_ERROR : DMA_COMPLETE;
> +		/* Make sure to use this for initialization */
> +		if (aml_chan->desc.cookie >= DMA_MIN_COOKIE)
> +			dma_cookie_complete(&aml_chan->desc);
> +		dmaengine_desc_get_callback_invoke(&aml_chan->desc, NULL);
> +		done &= ~BIT(i);
> +	}
> +
> +	/* deal with wch normal complete and error */
> +	regmap_read(aml_dma->regmap, DMA_BATCH_END, &end);
> +	if (end)
> +		regmap_write(aml_dma->regmap, CLEAR_W_BATCH, end);
> +
> +	regmap_read(aml_dma->regmap, WCH_DONE, &done);
> +	regmap_read(aml_dma->regmap, WCH_EOC_DONE, &eoc_done);
> +	done = done | eoc_done;
> +
> +	regmap_read(aml_dma->regmap, WCH_ERR, &err);
> +	regmap_read(aml_dma->regmap, WDMA_RESP_ERR, &err_l);
> +	err = err | err_l;
> +
> +	done = done | err;
> +	i = 0;
> +	while (done) {
> +		i = ffs(done) - 1;
> +		aml_chan = aml_dma->aml_wch[i];
> +		regmap_write(aml_dma->regmap, CLEAR_WCH, BIT(aml_chan->chan_id));
> +		if (!aml_chan) {
> +			dev_err(aml_dma->dma_device.dev, "idx %d wch not initialized\n", i);
> +			done &= ~BIT(i);
> +			continue;
> +		}
> +		aml_chan->status = (err & (1 << i)) ? DMA_ERROR : DMA_COMPLETE;
> +		if (aml_chan->desc.cookie >= DMA_MIN_COOKIE)
> +			dma_cookie_complete(&aml_chan->desc);
> +		dmaengine_desc_get_callback_invoke(&aml_chan->desc, NULL);
> +		done &= ~BIT(i);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static struct dma_chan *aml_of_dma_xlate(struct of_phandle_args *dma_spec, struct of_dma *ofdma)
> +{
> +	struct aml_dma_dev *aml_dma = (struct aml_dma_dev *)ofdma->of_dma_data;
> +	struct aml_dma_chan *aml_chan = NULL;
> +	u32 type;
> +	u32 phy_chan_id;
> +
> +	if (dma_spec->args_count != 2)
> +		return NULL;
> +
> +	type = dma_spec->args[0];
> +	phy_chan_id = dma_spec->args[1];
> +
> +	if (phy_chan_id >= MAX_CHAN_ID)
> +		return NULL;
> +
> +	if (type == AML_DMA_TYPE_TX) {
> +		aml_chan = aml_dma->aml_rch[phy_chan_id];
> +		if (!aml_chan) {
> +			if (aml_dma->chan_used >= aml_dma->chan_nr) {
> +				dev_err(aml_dma->dma_device.dev, "some dma clients err used\n");
> +				return NULL;
> +			}
> +			aml_chan = &aml_dma->aml_chans[aml_dma->chan_used];
> +			aml_dma->chan_used++;
> +			aml_chan->direction = DMA_MEM_TO_DEV;
> +			aml_chan->chan_id = phy_chan_id;
> +			aml_chan->reg_offs = RCH_REG_BASE + 0x40 * aml_chan->chan_id;
> +			aml_dma->aml_rch[phy_chan_id] = aml_chan;
> +		}
> +	} else if (type == AML_DMA_TYPE_RX) {
> +		aml_chan = aml_dma->aml_wch[phy_chan_id];
> +		if (!aml_chan) {
> +			if (aml_dma->chan_used >= aml_dma->chan_nr) {
> +				dev_err(aml_dma->dma_device.dev, "some dma clients err used\n");
> +				return NULL;
> +			}
> +			aml_chan = &aml_dma->aml_chans[aml_dma->chan_used];
> +			aml_dma->chan_used++;
> +			aml_chan->direction = DMA_DEV_TO_MEM;
> +			aml_chan->chan_id = phy_chan_id;
> +			aml_chan->reg_offs = WCH_REG_BASE + 0x40 * aml_chan->chan_id;
> +			aml_dma->aml_wch[phy_chan_id] = aml_chan;
> +		}
> +	} else {
> +		dev_err(aml_dma->dma_device.dev, "type %d not supported\n", type);
> +		return NULL;
> +	}
> +
> +	return dma_get_slave_channel(&aml_chan->chan);
> +}
> +
> +static int aml_dma_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct dma_device *dma_dev;
> +	struct aml_dma_dev *aml_dma;
> +	int ret, i, len;
> +	u32 chan_nr;
> +
> +	const struct regmap_config aml_regmap_config = {
> +		.reg_bits = 32,
> +		.val_bits = 32,
> +		.reg_stride = 4,
> +		.max_register = 0x3000,
> +	};
> +
> +	ret = of_property_read_u32(np, "dma-channels", &chan_nr);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "failed to read dma-channels\n");
> +
> +	len = sizeof(*aml_dma) + sizeof(struct aml_dma_chan) * chan_nr;
> +	aml_dma = devm_kzalloc(&pdev->dev, len, GFP_KERNEL);
> +	if (!aml_dma)
> +		return -ENOMEM;
> +
> +	aml_dma->chan_nr = chan_nr;
> +
> +	aml_dma->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(aml_dma->base))
> +		return PTR_ERR(aml_dma->base);
> +
> +	aml_dma->regmap = devm_regmap_init_mmio(&pdev->dev, aml_dma->base,
> +						&aml_regmap_config);
> +	if (IS_ERR_OR_NULL(aml_dma->regmap))
> +		return PTR_ERR(aml_dma->regmap);
> +
> +	aml_dma->clk = devm_clk_get_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(aml_dma->clk))
> +		return PTR_ERR(aml_dma->clk);
> +
> +	aml_dma->irq = platform_get_irq(pdev, 0);
> +
> +	aml_dma->pdev = pdev;
> +	aml_dma->dma_device.dev = &pdev->dev;
> +
> +	dma_dev = &aml_dma->dma_device;
> +	INIT_LIST_HEAD(&dma_dev->channels);
> +
> +	/* Initialize channel parameters */
> +	for (i = 0; i < chan_nr; i++) {
> +		struct aml_dma_chan *aml_chan = &aml_dma->aml_chans[i];
> +
> +		aml_chan->aml_dma = aml_dma;
> +		aml_chan->chan.device = &aml_dma->dma_device;
> +		dma_cookie_init(&aml_chan->chan);
> +
> +		/* Add the channel to aml_chan list */
> +		list_add_tail(&aml_chan->chan.device_node,
> +			      &aml_dma->dma_device.channels);
> +	}
> +	aml_dma->chan_used = 0;
> +
> +	dma_set_max_seg_size(dma_dev->dev, SG_MAX_LEN);
> +
> +	dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);
> +	dma_dev->device_alloc_chan_resources = aml_dma_alloc_chan_resources;
> +	dma_dev->device_free_chan_resources = aml_dma_free_chan_resources;
> +	dma_dev->device_tx_status = aml_dma_tx_status;
> +	dma_dev->device_prep_slave_sg = aml_dma_prep_slave_sg;
> +
> +	dma_dev->device_pause = aml_dma_pause_chan;
> +	dma_dev->device_resume = aml_dma_resume_chan;
> +	dma_dev->device_terminate_all = aml_dma_terminate_all;
> +	dma_dev->device_issue_pending = aml_dma_enable_chan;
> +	/* PIO 4 bytes and I2C 1 byte */
> +	dma_dev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES | DMA_SLAVE_BUSWIDTH_1_BYTE);
> +	dma_dev->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
> +	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
> +
> +	ret = dmaenginem_async_device_register(dma_dev);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "failed to register dmaenginem\n");
> +
> +	ret = of_dma_controller_register(np, aml_of_dma_xlate, aml_dma);
> +	if (ret)
> +		return ret;
> +
> +	regmap_write(aml_dma->regmap, RCH_INT_MASK, 0xffffffff);
> +	regmap_write(aml_dma->regmap, WCH_INT_MASK, 0xffffffff);
> +
> +	ret = devm_request_irq(&pdev->dev, aml_dma->irq, aml_dma_interrupt_handler,
> +			       IRQF_SHARED, dev_name(&pdev->dev), aml_dma);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "failed to reqest_irq\n");
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id aml_dma_ids[] = {
> +	{ .compatible = "amlogic,a9-dma", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, aml_dma_ids);
> +
> +static struct platform_driver aml_dma_driver = {
> +	.probe = aml_dma_probe,
> +	.driver		= {
> +		.name	= "aml-dma",
> +		.of_match_table = aml_dma_ids,
> +	},
> +};
> +
> +module_platform_driver(aml_dma_driver);
> +
> +MODULE_DESCRIPTION("GENERAL DMA driver for Amlogic");
> +MODULE_AUTHOR("Xianwei Zhao <xianwei.zhao@amlogic.com>");
> +MODULE_LICENSE("GPL");
>
> --
> 2.52.0
>

