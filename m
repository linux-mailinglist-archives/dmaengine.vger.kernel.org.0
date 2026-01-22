Return-Path: <dmaengine+bounces-8451-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gC1LL1aEcWk1IAAAu9opvQ
	(envelope-from <dmaengine+bounces-8451-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 22 Jan 2026 02:58:46 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C59609D1
	for <lists+dmaengine@lfdr.de>; Thu, 22 Jan 2026 02:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2E728445D64
	for <lists+dmaengine@lfdr.de>; Thu, 22 Jan 2026 01:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FF736923E;
	Thu, 22 Jan 2026 01:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lauFpQof"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013038.outbound.protection.outlook.com [52.101.83.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5DE352FBC;
	Thu, 22 Jan 2026 01:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769046893; cv=fail; b=bYbC+WGjM9sSgPFunXcujBPi9zOKxevC62UP08OtYqNc3nTwaneNJCm6v1oDiNVRtAzUD6r0/HD/KML/EhdT6MosiWLwCx9DjSJ4eClYZdK6mN4O7w3Oq8CoeODDaPPyD2gLBBVTHpuuV3EH5EG5FH41nu+GFXVPZir/Xd+ZZ9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769046893; c=relaxed/simple;
	bh=P8/5iFOZz+JTsI88gu/UH9NLz99r1RNahGof64RXfLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jNYpK7rOJyDcYvZPNZuQr+V7tNFV4qRytNnLbQYR1YekN9jnrKk9y2wzWhxHYtDPJaeygkjrLOwcqWR3VN8c6K2yoxFEv0vFaV7b29xI1qIywPwr0VPL3Ctf/sA/QmZClZj3n7mUQhqKmaPiz1c7e8UG66K+oEOVOfNCbzyWu4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lauFpQof; arc=fail smtp.client-ip=52.101.83.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IpAAc9lgIzn9pWlrWlSWIucDnPZ3f4qCkn7yGZ9XnTkFry4R4g6WlFZvfzcpU9LU46FDW+5WslkJnn2RbqyiCisbwArfLL7FI8K8xI8gJyngWCeLb75Z18ZE3hCOc3n3TknZ1Vcx0BjcdRR+MFpsOZfORNubzcX6fszpNAwXDC3unuEJ7RDJU6WaCnYXTipNoKsyGnf19TanjbC5KSIxpZz0/908tchvqfNKkcbWbv+YRF5dSIj2XBK6wPtTq4NvFzmDWsIzz2BB+Q0HmE7glJj35whw3g6jUDLBeaTeqb59VrtvTmrsDJkpBRHLZ1zVfhdx01P5zbOBKoJtesXWsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5q17GNhgc/zv000IMHJ/KLnICDEBcIN8cM2Oub6Hbxw=;
 b=XxpG6InwualJc93vFy1sQj3aMo8ZkKwDonGXz6msgrw5tHCOK+kx7m+n5q+ycbX6PqiNKBLfZxoltpKQ+zp6u53w8x1EB80/r55kSvzkBtnL7ae7tlXhsqw7c7ojbqjmD9GzAI+gbubVsrjUijf9kRiHjNEciPeglb5dfBPsZeHPYlmRQ/3tT+tC4V0EzQ5GlF5zOK0Gtl9gvCvO884w7KPEpk8+BM7jMRr/23wEtauxm7fkqOEMHuKWDG0useak2yRfbI7EUMoRH8nswEUlPDFi+cUdh3bGDVyMSRDYpO2OeQLKf8cQcqHL42qOSXWxaPPOxLdrRTbMvjZDH23hMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5q17GNhgc/zv000IMHJ/KLnICDEBcIN8cM2Oub6Hbxw=;
 b=lauFpQofenKpUIjtxbqIMsFC4sxdU19gmmsIHwz+0IvV50DqlKsFeIt2UM2Y6Hy6gwamQ0fdaGDXc2vWIkTJVuayVM9lJxW78TjzidPEPPUxo+TTkrGA+UpHn5Np75eVgcmqhg4SCvYadUhMSgqKyrEW1J/uhUWy836Rc2sFR8jFWvMa2CvM+w2L/EI76NVZst+8yOGU8IeuKwNBctDDfkWhOwFpHkwSEtXtsS8vi6SUNXw8+wRngwyUXmQdOJG/jtFGrCxsK5j3tnpaiVrbHm7r8yQZXo73tmB57XR/dcpej/P0z3GsH2yk+lq2gRcC6DP4qVlr8f//E0Mwvm/1Ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by AM0PR04MB11854.eurprd04.prod.outlook.com (2603:10a6:20b:6fc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 01:54:45 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9520.011; Thu, 22 Jan 2026
 01:54:45 +0000
Date: Wed, 21 Jan 2026 20:54:34 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: dave.jiang@intel.com, cassel@kernel.org, mani@kernel.org,
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com,
	geert+renesas@glider.be, robh@kernel.org, vkoul@kernel.org,
	jdmason@kudzu.us, allenbh@gmail.com, jingoohan1@gmail.com,
	lpieralisi@kernel.org, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org, iommu@lists.linux.dev,
	ntb@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, magnus.damm@gmail.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	andriy.shevchenko@linux.intel.com, jbrunet@baylibre.com,
	utkarsh02t@gmail.com
Subject: Re: [RFC PATCH v4 05/38] dmaengine: dw-edma: Add a helper to query
 linked-list region
Message-ID: <aXGDWiAxesCy1/yA@lizhi-Precision-Tower-5810>
References: <20260118135440.1958279-1-den@valinux.co.jp>
 <20260118135440.1958279-6-den@valinux.co.jp>
 <aW0S60D2uALBXdtQ@lizhi-Precision-Tower-5810>
 <e4y664ylum35wvj4endwprzpp4cvfaggklik5mxvdkgmakuqyj@lgevmhllem72>
 <tuhaxwmmcjfltih7ckfo2l5ltzicnj6zfc5ka3pvqlljn7ldu2@ibo5eo62lndn>
 <aXDvkRCZXQ/dPwRd@lizhi-Precision-Tower-5810>
 <42qzkekk6yqbtcynxny3f7pl3xg6tqkywxvjsgfmrdpnr7zy53@i7ebpgazbi4z>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42qzkekk6yqbtcynxny3f7pl3xg6tqkywxvjsgfmrdpnr7zy53@i7ebpgazbi4z>
X-ClientProxiedBy: PH8PR07CA0030.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::16) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|AM0PR04MB11854:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c432791-f2e2-4983-e9c2-08de595937b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iT3hu6WJQZ+tV8SPg2SKOIQAT3CneD9rxXorJkwHhYAy0ABdMbom019AuI8i?=
 =?us-ascii?Q?J+ody5JanrFDIbSDjSiFX+Rjld96mwM6mdk/kVjZy6IkRGK2+hFKGBswPUyo?=
 =?us-ascii?Q?X+MYq3OmSg1MuWilAcIH/6eUlSZgel3Bpp7/XV6ZETqU4n2ySrwBBL6MEqCm?=
 =?us-ascii?Q?pc2X47eMLqnMLQV6jQ+Hk4L54+LcuKY2ucXgUFN51D6Mx58meNbYdtx27hx/?=
 =?us-ascii?Q?dt9eATIqWLzP6xCKx1KkCJRlIMc4+Jfyteg9mzYL4e5ugDmilkQL1nmjbwHG?=
 =?us-ascii?Q?css3AChXKAq0JuNh6rfZN/EwFK4nujdhGSeUKfsK3t7JklTeUIKJKjn8p7Qs?=
 =?us-ascii?Q?Sa5DoaPfeezC+hoCNiHgl/QGy9c4VJDQHTse5vXtTef1CQP2rkeJn2g1fnNN?=
 =?us-ascii?Q?LTsT7Ue7MPxi8nlKcPCe3en4/z8jVb08I4rFAhurRWuxAj8cfd34yH0xv9eO?=
 =?us-ascii?Q?+HhjmfumGXyO+v3lh2bfzoAOsvY0F0zRbqqtN4x7TLYIxsfQy+JD1bIeRe3h?=
 =?us-ascii?Q?11R3ezRgZSFeY66hjtpiEYe9VUnctBNBKVyN3QYkhOSMESe6vRDUHCpynC7t?=
 =?us-ascii?Q?hIOp9+r1kBK0x1bbhH9zIGzVXVbvZzhXfrPa/r+85ZfxgnXASm37/Hea36Az?=
 =?us-ascii?Q?x4vppBkIE5E83cINaqBy6m1cyRx+kDRt0V3FxKwSnUw/OFtUkt0XFh3aw1TG?=
 =?us-ascii?Q?gVq0TQ0wc+5+AB43/Qh7Yk7d08edCNTARQEiLVyIEkFoH+ScjDN7+9NzMTnf?=
 =?us-ascii?Q?IfuW7mfilvXUinMH0sYAt149+F6iWGJ4WgQxMRFypWN1RUAApLheluYZ3/09?=
 =?us-ascii?Q?AsMSjncr9DTYPwjyoKr63/MbO98kj57wbOf9cFRMV3QFoaWT6r1skV30lt4Z?=
 =?us-ascii?Q?QYPY2gShtC5UOVJ5lC/VDQnBeG+axt/IEfOWLlBrBMNo5b4BZnKLGZThtdZB?=
 =?us-ascii?Q?huhuGrFqgs9AKwsDGmXyzWcmVrU8S4TzOroC8wPcDjJYC3UOF/Tu5ddlw115?=
 =?us-ascii?Q?gxxStzz8qEDS0IFsKiiJIribGTMfw87Xf0vC6Y1JU1UVTWM7igspin/+QIrf?=
 =?us-ascii?Q?9nduxzRqJepKNH7d/4FlBD2GZPxXr6dNlSrx/40xBlt2GV6sxNFKSVpv94Kj?=
 =?us-ascii?Q?mm0WAV6dKXNVdwxbZSoDmIIrr/sianqqO71xsULzwjxxCR8rz9rqiJ66YDvl?=
 =?us-ascii?Q?Y7BOPTOp3YUJqRwyJlbkXBUjRlRFpFl/WULuZ0CMrx5+hYzPcVjrb9frNTfy?=
 =?us-ascii?Q?vhHyrkI68ZoGwPGrLRx2PWJeUHYi/KsZp11EvsQYYIM0KGSQVmNmfGRXtoV7?=
 =?us-ascii?Q?+vVSwnkj5p689esjaLIFYZpTb+BXBVQzfX6FdVVFXISSi/vbVDVwGd9ex8Mz?=
 =?us-ascii?Q?EkajlLehcuJHeETyBn2OLXEZfz5iERbIJKZG4wHQKt28nBVXPliWLI3QAnVE?=
 =?us-ascii?Q?EPJM3SZv/loG+ntvo4Z05BzbhzI4YVAw3UrnmeNAqzLhSb6vjl+jpoGf0Jcy?=
 =?us-ascii?Q?/UejtYK1dK2fRvvqmorgp+KFYFGwyuP0ILYvBxYvuF7/IhHU0wLHaiYwi9FG?=
 =?us-ascii?Q?/eX4aAHwigk4Vgo8o0pwDbpYUPYBO5Wem+1QJ+ykV5+2Ums9tCRmgduEd+Zx?=
 =?us-ascii?Q?cNM72Y+k5ra7ngOWdTVI6EY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fRSBEWjqRI27otdZLvIFNIjb52nsVcDZArYbEAnRAXdazot5v94R2drZkaXW?=
 =?us-ascii?Q?aTt2rZKiCF5wuzppSZv5gAV7kMn18phss2s4rFMMRN97ueJwsoB61fNDPQqy?=
 =?us-ascii?Q?kdqoYZ+9+ReJiKoovdWnju7cUAUd0EIhWdjUZvC4dVdyKqe1QHfQ+ncpnNe/?=
 =?us-ascii?Q?+D+THix0u0UwWXuGI1jwH3i5bMfmuIP17DeN+2Expg2TafsJUuntCZqF8TuS?=
 =?us-ascii?Q?+qRokOGPM9p4inivR38/Jvf3Yq7molqJrdvyRWJxN4giXbf7jnHttL2PtX8d?=
 =?us-ascii?Q?ibrjjzf17Jh37LHigwiDtySlXkEGufK+9cq8EuFENzUgFOFFBJX5d1ATwHEY?=
 =?us-ascii?Q?f1ksfXQASBycbXQPz0bAgAQUCZ3y6DmNRnls84NCMS7VC+CyM+8KNxAwSTaa?=
 =?us-ascii?Q?2bm7nLOO6LSdg3xZEaVpcoaKNpqbmT2cKHC3yGCVVAFN8wPyQ4ynzMuYO2vq?=
 =?us-ascii?Q?TyNMV0Y5/eP1u2L8/Ajgga5cgksTsnW1TU+pnsqV1iyZ3y+HJC0q+UirP5DZ?=
 =?us-ascii?Q?zO8Iy99nL78XiF0umODjwEBQuX/ss8CDhTYQZWos41o+CiFU6k42dWnqTKr/?=
 =?us-ascii?Q?FlyRBvzIrqrxeC9QWxqyD2yg59wcJA0OlF3awea1WypxavVg94dotIW5q13n?=
 =?us-ascii?Q?dRSkNigPCzBav41jn2XNjtM3GtmIUuTzKHfrRd9yuYqykCMo6SgZAfA33Do2?=
 =?us-ascii?Q?f+119BymbiDIbS9NMxcuyUxLBWGHv4FookhhxkghCbVSLlurm2HkX1OklQ60?=
 =?us-ascii?Q?2t48ElvCF9Mpyb3sy5E4WOodcByvE3pv1T6R/fj8c36dznn3IHPsd7Yqn5Gw?=
 =?us-ascii?Q?qKGVle7uCjxWSrM+HDgeneQptYi2fEI2VQfQdTiAO8YXkk9Llg4gshXjZLxk?=
 =?us-ascii?Q?GGcyVPRn/HZCI4+ISKDFDykf0LefdnHBgSLc2hj4ePJNoSbOGcxOFXzZU9jD?=
 =?us-ascii?Q?NaldKQSyL8ZbTuN3Zek1OfJGsBC5zbjOPbnnqT/LmWk9l1eth5RQ6+ZRGFu5?=
 =?us-ascii?Q?dJB2gitZV7LpqXzv4Tr6jBcFLm4yVPr4kjB2F/a1WzQcFNtNOA9F+3g0/NAt?=
 =?us-ascii?Q?6iwT67ECBj1bVQgy7cdkrtT40BjFwaaEJk3bC9S7RRN9zhREK985HR9mG8mR?=
 =?us-ascii?Q?6yolxBbv4gk6kAzIM7ZPrLcY/VhvbSab2X7wetBQYBT9ly8X0KIKt8AhuCYN?=
 =?us-ascii?Q?rk4/+4NeSE7/wC6IyQIYC6WkAJF/+6mr6Vo4bV1sQidZTIhkhLJLx3HhUCVQ?=
 =?us-ascii?Q?9w+l365Om3XIZUh0ZzPCvmfzGZCxVGBBkdUpj8HI/ceYefoxhmo/Lq9lD+pC?=
 =?us-ascii?Q?GSlPPnwf6wksABtTe7/VIOdnISS/0dg+rlkbEiNaPF9FgwdKxMA/cRB8AUeg?=
 =?us-ascii?Q?PvAaCyWFTJJegG/XSmWdC+1kpc54PrriT1HiLmdPmnYRV0xhoqYf0tYByBoE?=
 =?us-ascii?Q?DUqUkqjYzImrDcMR+n0farZuSugvYq6CaguLLsP0DsFnbJ/sgwHzoKeE4Ck6?=
 =?us-ascii?Q?/JYuYNCbm6U3SMuQ5+9/2gSwcWqmjUCYgpAcD5zHJo5zdJ5qgtipuIkjd9u/?=
 =?us-ascii?Q?wPI+JiRDkEz9W74neXAFapFOqzNihCJc8XwjZbHd5Q4ccj7AS3qh5fdxkk8p?=
 =?us-ascii?Q?ikgQ8PeCF0ra9QHJwyB/n6ZaTaoOiiCRX1NnR/6Rv0odV7hlsmm1mNH395UZ?=
 =?us-ascii?Q?M8zJYkqQ+WSW7RVNPOLJfDHk0qZZSMmpXREfzPYeke2FxJpK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c432791-f2e2-4983-e9c2-08de595937b8
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 01:54:45.7347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i6Dlg9lY0m5feEOvHmtsv/+DdmJtjNIGhBmOG8g/zK4v9X3EPQ2EciRgO+Qk1hStCjU0oAR3PaxehT1MHLbffA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB11854
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8451-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	FREEMAIL_CC(0.00)[intel.com,kernel.org,google.com,glider.be,kudzu.us,gmail.com,vger.kernel.org,lists.linux.dev,arndb.de,linuxfoundation.org,8bytes.org,arm.com,lwn.net,linux.intel.com,baylibre.com];
	DKIM_TRACE(0.00)[nxp.com:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[nxp.com,none];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Queue-Id: 64C59609D1
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 10:19:24AM +0900, Koichiro Den wrote:
> On Wed, Jan 21, 2026 at 10:24:01AM -0500, Frank Li wrote:
> > On Wed, Jan 21, 2026 at 05:41:11PM +0900, Koichiro Den wrote:
> > > On Wed, Jan 21, 2026 at 10:38:53AM +0900, Koichiro Den wrote:
> > > > On Sun, Jan 18, 2026 at 12:05:47PM -0500, Frank Li wrote:
> > > > > On Sun, Jan 18, 2026 at 10:54:07PM +0900, Koichiro Den wrote:
> > > > > > A remote eDMA provider may need to expose the linked-list (LL) memory
> > > > > > region that was configured by platform glue (typically at boot), so the
> > > > > > peer (host) can map it and operate the remote view of the controller.
> > > > > >
> > > > > > Export dw_edma_chan_get_ll_region() to return the LL region associated
> > > > > > with a given dma_chan.
> > > > >
> > > > > This informaiton passed from dwc epc driver. Is it possible to get it from
> > > > > EPC driver.
> > > >
> > > > That makes sense, from an API cleanness perspective, thanks.
> > > > I'll add a helper function dw_pcie_edma_get_ll_region() in
> > > > drivers/pci/controller/dwc/pcie-designware.c, instead of the current
> > > > dw_edma_chan_get_ll_region() in dw-edma-core.c.
> > >
> > > Hi Frank,
> > >
> > > I looked into exposing LL regions from the EPC driver side, but the key
> > > issue is channel identification under possibly concurrent dmaengine users.
> > > In practice, the only stable handle a consumer has is a pointer to struct
> > > dma_chan, and the only reliable way to map that to the eDMA hardware
> > > channel is via dw_edma_chan->id.
> >
> > If possible, I suggest change to one page pre-channel. So there are a fixed
> > ll mapping.
>
> I agree that this would make the LL layout more deterministic and would
> indeed simplify locating the region for a given dw_edma_chan ID. That said,
> my concern was that even with a fixed per-channel layout, we still need a
> reliable way to map a struct dma_chan obtained by a consumer to the
> corresponding dw_edma_chan ID, especially in the presence of potentially
> concurrent dmaengine users.
>
> >
> > > I think an EPC-facing API would still need
> > > that mapping in any case, so keeping the helper in dw-edma seems simpler
> > > and more robust.
> > > If you have another idea, I'd appreciate your insights.
> >
> > I suggest add generally DMA engine API to get such property, some likes
> > a kind ioctrl \ dma_get_config().
>
> I think such a helper, combined with your one page per-channel idea, would
> resolve the issue cleanly. For example, a helper like dma_get_hw_info()
> returning struct dma_hw_info, whose first field is a hw_id, could work
> well. Consumers could then use this helper, and if they know they are
> dealing with a dw-edma channel, they can derive the LL location
> straightforwardly as {hw_id * fixed_stride (e.g. PAGE_SIZE)}. Adding hw_id
> to struct dma_slave_caps would make the necessary diff smaller, but I think
> it would not semantically fit in the structure.

It is worth to try.

Frank
>
> Thanks,
> Koichiro
>
> >
> > Frank
> >
> > >
> > > Regards,
> > > Koichiro
> > >
> > > >
> > > > Thanks for the review,
> > > > Koichiro
> > > >
> > > > >
> > > > > Frank
> > > > > >
> > > > > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > > > > ---
> > > > > >  drivers/dma/dw-edma/dw-edma-core.c | 26 ++++++++++++++++++++++++++
> > > > > >  include/linux/dma/edma.h           | 14 ++++++++++++++
> > > > > >  2 files changed, 40 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > index 0eb8fc1dcc34..c4fb66a9b5f5 100644
> > > > > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > @@ -1209,6 +1209,32 @@ int dw_edma_chan_register_notify(struct dma_chan *dchan,
> > > > > >  }
> > > > > >  EXPORT_SYMBOL_GPL(dw_edma_chan_register_notify);
> > > > > >
> > > > > > +int dw_edma_chan_get_ll_region(struct dma_chan *dchan,
> > > > > > +			       struct dw_edma_region *region)
> > > > > > +{
> > > > > > +	struct dw_edma_chip *chip;
> > > > > > +	struct dw_edma_chan *chan;
> > > > > > +
> > > > > > +	if (!dchan || !region || !dchan->device)
> > > > > > +		return -ENODEV;
> > > > > > +
> > > > > > +	chan = dchan2dw_edma_chan(dchan);
> > > > > > +	if (!chan)
> > > > > > +		return -ENODEV;
> > > > > > +
> > > > > > +	chip = chan->dw->chip;
> > > > > > +	if (!(chip->flags & DW_EDMA_CHIP_LOCAL))
> > > > > > +		return -EINVAL;
> > > > > > +
> > > > > > +	if (chan->dir == EDMA_DIR_WRITE)
> > > > > > +		*region = chip->ll_region_wr[chan->id];
> > > > > > +	else
> > > > > > +		*region = chip->ll_region_rd[chan->id];
> > > > > > +
> > > > > > +	return 0;
> > > > > > +}
> > > > > > +EXPORT_SYMBOL_GPL(dw_edma_chan_get_ll_region);
> > > > > > +
> > > > > >  MODULE_LICENSE("GPL v2");
> > > > > >  MODULE_DESCRIPTION("Synopsys DesignWare eDMA controller core driver");
> > > > > >  MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
> > > > > > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > > > > > index 3c538246de07..c9ec426e27ec 100644
> > > > > > --- a/include/linux/dma/edma.h
> > > > > > +++ b/include/linux/dma/edma.h
> > > > > > @@ -153,6 +153,14 @@ bool dw_edma_chan_ignore_irq(struct dma_chan *chan);
> > > > > >  int dw_edma_chan_register_notify(struct dma_chan *chan,
> > > > > >  				 void (*cb)(struct dma_chan *chan, void *user),
> > > > > >  				 void *user);
> > > > > > +
> > > > > > +/**
> > > > > > + * dw_edma_chan_get_ll_region - get linked list (LL) memory for a dma_chan
> > > > > > + * @chan: the target DMA channel
> > > > > > + * @region: output parameter returning the corresponding LL region
> > > > > > + */
> > > > > > +int dw_edma_chan_get_ll_region(struct dma_chan *chan,
> > > > > > +			       struct dw_edma_region *region);
> > > > > >  #else
> > > > > >  static inline int dw_edma_probe(struct dw_edma_chip *chip)
> > > > > >  {
> > > > > > @@ -182,6 +190,12 @@ static inline int dw_edma_chan_register_notify(struct dma_chan *chan,
> > > > > >  {
> > > > > >  	return -ENODEV;
> > > > > >  }
> > > > > > +
> > > > > > +static inline int dw_edma_chan_get_ll_region(struct dma_chan *chan,
> > > > > > +					     struct dw_edma_region *region)
> > > > > > +{
> > > > > > +	return -EINVAL;
> > > > > > +}
> > > > > >  #endif /* CONFIG_DW_EDMA */
> > > > > >
> > > > > >  struct pci_epc;
> > > > > > --
> > > > > > 2.51.0
> > > > > >

