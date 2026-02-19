Return-Path: <dmaengine+bounces-8980-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAu8AW9Dl2nzwAIAu9opvQ
	(envelope-from <dmaengine+bounces-8980-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 19 Feb 2026 18:07:59 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57974160F22
	for <lists+dmaengine@lfdr.de>; Thu, 19 Feb 2026 18:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA2E8301CF87
	for <lists+dmaengine@lfdr.de>; Thu, 19 Feb 2026 17:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B7C2F6911;
	Thu, 19 Feb 2026 17:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GHhZUhGP"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013027.outbound.protection.outlook.com [40.107.162.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4002C1589;
	Thu, 19 Feb 2026 17:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771520876; cv=fail; b=GrjLeTdV3L+ear8e+MHPTzrCNi3te+B+QAqiLXMEIla11ob/x0JDXL08WrKFXkgzBMU+pIuX3hxy7CNJl4fzDXLSAAI92hrXmJfkbVr9RFGT8dSEfy3/vnTY62H3VNPwZjpFWFV0n/6axhd+Yg3bMtaY15R45ZPpaN0Qg/pdePM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771520876; c=relaxed/simple;
	bh=Mx1O+BKEGZ3T8Zx0/RxAvSWDCfU/9G0pcQ110FCDXY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AjpoTm1X6TaO1i9cEsHWAjgHxx1VWL9phhd65GWgw7BiiAGzctF6yJu2wjckE/KMOpyovAw4FdHx46JnkqcU5yXffLu/PSZzCP3khuVvLqszRsvlxIMl4OumTjhHIz0zvl5CIvuYjlHmORS56aZT7RCjW/GjWkYq+guPmBD1DRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GHhZUhGP; arc=fail smtp.client-ip=40.107.162.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rYn3ez8mMkxARbRAunlRFnjMhUaFJ0dO4NSyQ2a+aOZ/ECsj+8/6b9LWA96LkxwZ1g2Hw2xmOQZIq35F2N3AGK7joWODvgLJc+3PInDewPRMJOc19e3NTovp9CaL46eelfSDwQxRaH+GOs4AplAxaWdNIdkIDt2yWIB7ElXgPBW4N6bOtsg4Nrilu/55qcVW3Pio2tkz/AjLo8VLygU/Rpd7THIV7spi5vW3QiDjGFzlklK3caIakZRgV6qt6/K++egGDessTzsFNc4h9ctpTLWsyLFjDvQ+ZhvQMrdSXbeSwtBRqYJtmuq+tt1DRicnabA2Cw70Ms7+S8hgNUTuVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25fuHk1DetpnXdrhh87k28lS5aVysuLN05bGqD1lhyA=;
 b=LhW/w9kD9WvdPDpqTGRvR6V6QnBKbRJN17mUr63044NW0tIQei4atlWjSmFXIn9xJDVJEg2aE22kZiGONa8/cL8SKk0QKPz5tEdcyeVnw87sbu8hKY20ZGwHjSqqEXp4O6OwzKkgYUjLSzxtko9CfrEN85jUw43PGOBNM/m6wcmXtuUBQ6v+6Q5dbJaUOSrueIzBBBMySnBjDXI04rQcJ3ggsjlq2ScsAfcTCQ6JGMue+gYTGmG11N4w8rusuGw1FATyYXV/VzT/xPWUklSOs3VWoJwMeQzFs8Cplin7xAdK7X5eQoIYdPzpnPxZg7quISeP3D8UV2RzL+Qh4n7bUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25fuHk1DetpnXdrhh87k28lS5aVysuLN05bGqD1lhyA=;
 b=GHhZUhGPHGu8sf4qRjniGiaUPYiSAg587B2PXjs5i7KbnHeFsGEF196HsGh3GJ2veZogJkAq9487VPp7vNkEoclbKFlRl7Z+uvTzoUxxYy/7GV+yWmfwZZ43DdsEnv1YzwsKWzAK4cDVW4gXD4ry7Jk5OmDu4nN4OAhRc1lmk3mRlNTEgNmlq+7N5w1qzaZ4flEBWJ0JlNpGrKpGGYM9angFl0NK2i7ud7NMSDMBFqq7gakWBHETQP0nyWBegHI+aWTxhomgw9ZnKRkysDA1iVOuTWU8aMryoU/qrblCQNL+QmL+dLSjeuNQa6n/ihHSxTeWgacewEa3fjsQxeNCPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by VI0PR04MB10952.eurprd04.prod.outlook.com (2603:10a6:800:268::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 17:07:51 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 17:07:51 +0000
Date: Thu, 19 Feb 2026 12:07:44 -0500
From: Frank Li <Frank.li@nxp.com>
To: "Verma, Devendra" <Devendra.Verma@amd.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"mani@kernel.org" <mani@kernel.org>,
	"vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Simek, Michal" <michal.simek@amd.com>
Subject: Re: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add non-LL mode
Message-ID: <aZdDYJIUuceu0guJ@lizhi-Precision-Tower-5810>
References: <20260216105547.13457-1-devendra.verma@amd.com>
 <20260216105547.13457-3-devendra.verma@amd.com>
 <aZNz3DxDdzuIf2Ar@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120CDACB96008B2BD4246D3956DA@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aZSZrROMrvt8jHvw@lizhi-Precision-Tower-5810>
 <SA1PR12MB812019D701E0B188611DFE7D956AA@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aZXfmKs5_KzCDSPq@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120DC54060E415153AA8CDE956BA@SA1PR12MB8120.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR12MB8120DC54060E415153AA8CDE956BA@SA1PR12MB8120.namprd12.prod.outlook.com>
X-ClientProxiedBy: PH8P222CA0002.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::31) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|VI0PR04MB10952:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a056788-0bdc-4e39-6555-08de6fd96a11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l19lnDUviKZh23H7fUCVLFZ14Le1mX3PCEGIEbDRIzbRO8tTmwldczU6zlnI?=
 =?us-ascii?Q?2cSduT7shc+UMXh4vMg4a6PeS5tFnR5amXcxxAzfcvtJyPfCcJYrdx1Mda17?=
 =?us-ascii?Q?wyr3ySc8d3TNpwKhzweJ2hBgB7S4+0HCWr/aUlpdQ1poxU0/GyyX0rtFg1Gt?=
 =?us-ascii?Q?5bTg7l/dg3bdkLh7Y65jsTwQnwiWG2j7YQecPzHlA3r/QIG8yo+yqVaizD8C?=
 =?us-ascii?Q?nwrXra6H9VdZigqyI9wJMBtoHu8OwaOZJTGBpvaMO/VLAxGUc22V0yPQGeEp?=
 =?us-ascii?Q?5vjNJZNfqO5J++yP2glF8foFnf76u0FyB9LIsfL2TzXK9kjcSnbJhtEB4csV?=
 =?us-ascii?Q?4JR9nwU/0IH3xZhL+wJ3UC440tpxZM6fvAV3IFpdnAX9LMfsIaFmHUN/+1X4?=
 =?us-ascii?Q?Iao5/JGu6Cf+QQq51ZJvxZjbGF336DEXImiX+GW3ym9Ej+TpzbmBueYuTOtu?=
 =?us-ascii?Q?lPEGqYlpzRPaQXeeK/VjdvxCEt7z9kfzYWR1nb1pWSRnGoLC5xQHgh0KMyAX?=
 =?us-ascii?Q?KhJRbKXy7ikqvdLfES83wCWGtykqYxM2tBwDkyqFupYoOsKB2VRue8IdDN6B?=
 =?us-ascii?Q?R/R0Tk+UAAmu+qwJjEfI1JKv0ZRK0yc+vTKqOQi1zaxA9afVGq65DQqsCKY9?=
 =?us-ascii?Q?6B3NS9zXSd38ILgrsTxDoEyb41/0fEYgLmhNWA0V9nu8A96Md00nIQSWYs6W?=
 =?us-ascii?Q?dpgwGwaJyWZd4casgzcEUnMyaPEewSLhp+QnWyefbduqNQ2lklx0j1VvDFsl?=
 =?us-ascii?Q?Zi92hxTkluSxCCylcw9T51Z+sJDW+oin8BcHj5UKwtXu1GjchWaK+UD8lKAL?=
 =?us-ascii?Q?8IfQ/6aCZhRMBTzLPvuKjoGjC4sNgKJVwWq99stKvrkM99F2Iwrvwj48syyy?=
 =?us-ascii?Q?7jQloXTqxy3VWGbigMFlRk0e/20y8h7l1SkW7kg1o/yqbS6qNYXbCe+TYwg0?=
 =?us-ascii?Q?rhi2/N5z63ucqbKWa+yvfhS92lqX5OG1F9jwfc4+OlNzk9VTy3cJlTWZyYHE?=
 =?us-ascii?Q?G6kXbevChs0vQlHQuJa0EblsqLDX3w2q0oXREKBBF3Yt1Bl30Zmz8cF1iVRA?=
 =?us-ascii?Q?iJBhSsePT14bZUL/L810HdOb/6W0jixPtWCvbTYYnkflI2Hu7VFwinRl1XJV?=
 =?us-ascii?Q?YmwcaHNJvyXLrHnVPv1E4j/NcM7aBa+K9ibZxIL/ym4mvHPscYcmUnXsGo3W?=
 =?us-ascii?Q?QIfnguFCMODcVB1bFDtZ7IjPSbLRGVQxKkdixsEa4P7aqsO/08q/cK4eWfNC?=
 =?us-ascii?Q?7ofxpl+NsG7sIHEJ961N1st5UGr5nUrmrAd2UYK5tSV5maAlW5gOtEa18czP?=
 =?us-ascii?Q?JpVM6RuMpKVxFFxG4kXqAqDvgE/myzssjlIKLvPt41RJecyvbnG9ONAJPHh6?=
 =?us-ascii?Q?Eoft2UhrUWnpg3OzxVXcqOQI/eycHcN9k790KlQLp+Lrh6r7yH0/yVhHdOyx?=
 =?us-ascii?Q?g8Ts1EYE2xmmf9wLRGXog7FmXWhWXPONOFLTyT+2lFRC2aQ+16QgHJvXyOcl?=
 =?us-ascii?Q?QSpD9/9v6MuUbkU1if413XNAbg2B8UqnV9p/KKviSK5/hGntmfrtOW9QA2eF?=
 =?us-ascii?Q?nB4DzCv/eVNxtJ9TB8HF7l+YYR62iH0jTxwMt03PaSKCQjFI9X7+ASOisYQz?=
 =?us-ascii?Q?svEtt19f2d9/O2lHKt4WCHo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NOlEJr3X6tXhsYQrKmFAL3Xt4vQFafSFcAw0NxiXCSdGxY89emQ6ILBbs6vY?=
 =?us-ascii?Q?yRNE+Nw54ucQRDr55/a/V8gEBt0CCRSaFBzN2/VsOaDmmZE2jBZdfRe6HAqZ?=
 =?us-ascii?Q?bhofxV5saZLrFoFyqJCZPwoMpHAOTBs/S/8yiv5cvJMeY30M9S7oe8GupBWE?=
 =?us-ascii?Q?WcXtRJzoD784qZl0rYp0CNvS957HUYiRAvXIq0mCZPxbuguLpUG1lh5inpW2?=
 =?us-ascii?Q?pe2QA7ULjoqPxKDHzCmBueR8+2FJ6TI7GMY2AjIfWaXy6SoOeJg546WRWJ4U?=
 =?us-ascii?Q?uS8MZ9A3JnjTLsliuhgyIPKqCYlKB/GqkuA2ms4y94MfLYpJLUsh0I0P29M/?=
 =?us-ascii?Q?R0lZNMCB7zqCuXe96wD9Upl5MekZhlHClbJkIdhiQMvYW9jdT0NNXP+5oAzY?=
 =?us-ascii?Q?+9cUK6MW1VGHwh1/xM3/bEPSMVFMR30OJWduTanZyv4eYk4CiNULfehVsP6h?=
 =?us-ascii?Q?6syHZujKcMTvpmLo8AwGruUj3mYjtrtzhwAfbs9lCdWMVyOp8ynhhZMWKXzk?=
 =?us-ascii?Q?RMzCCvXd+cDBMZHKwIbPW3bUGAAgi5apFIEjqQuAhB2rrNxPUONMWroMJwXV?=
 =?us-ascii?Q?HTCFnDqsGbGfKTOP20JpBwS150XYY+C18U6fEjCsR5wLbeLLsr1taN8MA6WX?=
 =?us-ascii?Q?opW2I5XT/wibjj2nrDwLwXIk2bLVz072kiESqgACo4YGwF5w87s7p89OZVh/?=
 =?us-ascii?Q?YubUaPhCW3gUPeK2TqwVoKlW2Sn2Tgwzq/JwRHjY8a8w4tZlLBlhQl2td+zc?=
 =?us-ascii?Q?CV672Zd3sQ6640jfhdYsNvwgjZ7/b7IC585I8xwUTPcrjnEB2Uy8++XKUQ8D?=
 =?us-ascii?Q?BwGacP/OxKCNEMpsAFVqeUWN8FnOOCg5Zcf9iWNLYtZAHbqkLmwlA0fe9UHT?=
 =?us-ascii?Q?4x2CRWC5MdPn7dsj6t2b8uT22J1XZBZzJjaWqYnlrch8LKRyD1g2pXQSH5Eb?=
 =?us-ascii?Q?JBbQdATDSXPnJK8W3S+7j7qTlBiE29wo3r0vT1TwmOIew2hhyNWRs85v8TpD?=
 =?us-ascii?Q?T8cYPD4tvsQrM/Ub3JXQI5SfXBaYuFEhS6V1Wig3ZXbiFSrHcnBxW625CyL2?=
 =?us-ascii?Q?SRHDCKRhYbh+ZlMF5Ev3dd7On99UAFwCBti5yyQnrhTKHeuVrP4zPN8Tj9Iz?=
 =?us-ascii?Q?CnE8VixopAbajm+IuVekZKENx658MBxxw68vLyP374zpFB+JFdIyJs1eabyH?=
 =?us-ascii?Q?XJ3MgRAuVC2I2iUfIugojGTntR4S7Qt/EWpB89yt91rcI9JI4Zd8dnuqiziE?=
 =?us-ascii?Q?uldezLOCjQPvw3lOJoBGu/pYI6xh8vwQ1mjTWsKfs8H8N41isLNcak1p0sTJ?=
 =?us-ascii?Q?ZVgO30nv0zyneVyhiHLy9xOByjqOU4hsAieQ40NTK8ZJ5BV3i+xWCIwB5Rq8?=
 =?us-ascii?Q?PV/qat6SYsJH97k+hIuVFo+0J1aA/iJgkMOzYbAvuydRlI0oAnk3sUND1QKx?=
 =?us-ascii?Q?pNtWJaOrKyWFEkhwOtMu4CFq+M8Q59deK1un3OInG/2CffdjWU36lLLbkSFr?=
 =?us-ascii?Q?m/DHzL2jaG17tRCDhzV/GKJpgtnlJoJjx2mEuTYgX13eWPZVRcwoetN3Ywxx?=
 =?us-ascii?Q?eHfDMGtC7tOei6YgkS/RZ3Nr4f1Tf5fd6EqNMkEmvnSyw9+MmdXncjOoENJl?=
 =?us-ascii?Q?T2+tKrkmEM0V+PY2RQkmDtSYlDYU0ui3cJLr2DgeCFuKZo6/Ch/xoLSViFxq?=
 =?us-ascii?Q?+rqFFlG0v8vE3aBXskOsA8uuzMOcFPN8LZtfgThpTBKAMLBN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a056788-0bdc-4e39-6555-08de6fd96a11
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 17:07:51.3752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JJ1EIUCtJ9RygVSKpTBAJBPA8vu0PP3zZs7FGXURktDwjqL77vj5bjnulJ3An48CHYFCVFl4D3KJkJY0Jb73qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10952
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8980-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim]
X-Rspamd-Queue-Id: 57974160F22
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 09:55:49AM +0000, Verma, Devendra wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> > -----Original Message-----
> > From: Frank Li <Frank.li@nxp.com>
> > Sent: Wednesday, February 18, 2026 9:20 PM
> > To: Verma, Devendra <Devendra.Verma@amd.com>
> > Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> > dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> > Subject: Re: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add non-LL
> > mode
>
> ---[ Snipped some text to reduce mail size ]---
>
> > > > > > On Mon, Feb 16, 2026 at 04:25:46PM +0530, Devendra K Verma wrote:
> > > > > > > AMD MDB IP supports Linked List (LL) mode as well as non-LL mode.
> > > > > > > The current code does not have the mechanisms to enable the
> > > > > > > DMA transactions using the non-LL mode. The following two
> > > > > > > cases are added with this patch:
> > > > > > > - For the AMD (Xilinx) only, when a valid physical base address of
> > > > > > >   the device side DDR is not configured, then the IP can still be
> > > > > > >   used in non-LL mode. For all the channels DMA transactions will
> > > > > > >   be using the non-LL mode only. This, the default non-LL mode,
> > > > > > >   is not applicable for Synopsys IP with the current code addition.
> > > > > > >
> > > > > > > - If the default mode is LL-mode, for both AMD (Xilinx) and Synosys,
> > > > > > >   and if user wants to use non-LL mode then user can do so via
> > > > > > >   configuring the peripheral_config param of dma_slave_config.
> > > > > > >
> > > > > > > Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> > > > > > > ---
> > > > > > > Changes in v10
> > > > > > >   Added the peripheral_config check only for HDMA IP in
> > > > > > >   dw_edma_device_config().
> > > > > > >   Replaced the loop with single entry retrieval for non-LL
> > > > > > >   mode.
> > > > > > >   Addressed review comments and handled the burst allocation
> > > > > > >   by defining 'bursts_max' as per suggestions.
> > > > > > >
> > > > > > > Changes in v9
> > > > > > >   Fixed compilation errors related to macro name mismatch.
> > > > > > >
> > > > > > > Changes in v8
> > > > > > >   Cosmetic change related to comment and code.
> > > > > > >
> > > > > > > Changes in v7
> > > > > > >   No change
> > > > > > >
> > > > > > > Changes in v6
> > > > > > >   Gave definition to bits used for channel configuration.
> > > > > > >   Removed the comment related to doorbell.
> > > > > > >
> > > > > > > Changes in v5
> > > > > > >   Variable name 'nollp' changed to 'non_ll'.
> > > > > > >   In the dw_edma_device_config() WARN_ON replaced with
> > dev_err().
> > > > > > >   Comments follow the 80-column guideline.
> > > > > > >
> > > > > > > Changes in v4
> > > > > > >   No change
> > > > > > >
> > > > > > > Changes in v3
> > > > > > >   No change
> > > > > > >
> > > > > > > Changes in v2
> > > > > > >   Reverted the function return type to u64 for
> > > > > > >   dw_edma_get_phys_addr().
> > > > > > >
> > > > > > > Changes in v1
> > > > > > >   Changed the function return type for dw_edma_get_phys_addr().
> > > > > > >   Corrected the typo raised in review.
> > > > > > > ---
> > > > > > >  drivers/dma/dw-edma/dw-edma-core.c    | 35 ++++++++++++++-
> > > > > > >  drivers/dma/dw-edma/dw-edma-core.h    |  1 +
> > > > > > >  drivers/dma/dw-edma/dw-edma-pcie.c    | 44 ++++++++++++------
> > > > > > >  drivers/dma/dw-edma/dw-hdma-v0-core.c | 65
> > > > > > > ++++++++++++++++++++++++++-  drivers/dma/dw-edma/dw-hdma-
> > v0-
> > > > > > regs.h |  1 +
> > > > > > >  include/linux/dma/edma.h              |  1 +
> > > > > > >  6 files changed, 132 insertions(+), 15 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > > b/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > > index b43255f914f3..ef3d79a9f88d 100644
> > > > > > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > > @@ -223,6 +223,31 @@ static int dw_edma_device_config(struct
> > > > > > dma_chan *dchan,
> > > > > > >                                struct dma_slave_config *config)  {
> > > > > > >       struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> > > > > > > +     int non_ll = 0;
> > > > > > > +
> > > > > > > +     chan->non_ll = false;
> > > > > > > +     if (chan->dw->chip->mf == EDMA_MF_HDMA_NATIVE) {
> > > > > >
> > > > > > Need handle EMDA case. if mf is EDMA, need return error when
> > > > > > config->peripheral_config is not NULL. Or remove above check to
> > > > > > config->make
> > > > > > code work for both EDMA or HDMA.
> > > > > >
> > > > >
> > > > > For the case of EDMA, the behavior is unchanged.
> > > > > Even if the config->peripheral_config param is set then it would
> > > > > be simply
> > > > ignored.
> > > > > This is retention of the previous behavior. This is done because
> > > > > device_slave_config has other params which affect the behavior of
> > > > > the DMA transactions, we do not check all those params and return
> > > > > any error. The error is returned only in the cases where
> > > > > particular parameter from dma_slave_config is used and if the
> > > > > parameter is not as expected or in the expected form. The
> > > > > parameter used from dma_slave_config for the particular IP type
> > > > > need to be known first then it
> > > > can be checked for its correctness. This is behavior for the
> > > > peripheral_config which is used for HDMA and thus error checked.
> > > >
> > > > It actaully hidden error. Your patch provide an option, which need't
> > > > ll memory to do DMA transfer. DMA consumer actaully don't know which
> > > > backend used, which is private information by DMA engine providor.
> > > >
> > > > dw-edma-pcie.c is only one of all edma users, which know DMA
> > > > engine's information because it creates this interface.
> > > >
> > > > PCIE-EP framework also create dmaegine, PCIE-EP function driver use
> > > > DMA standard interface to get dma-chan.
> > > >
> > > > if (config->peripheral_config) { /* only your specific dma consumer
> > > > set it now */
> > > >         /* optional config information */
> > > >         if (chan->dw->chip->mf != EDMA_MF_HDMA_NATIVE) {
> > > >                 dev_err("edma have not implmentent no-lll mode\n")
> > > >                 return -EINVAL
> > > >         }
> > > >
> > > >         ...
> > > > }
> > > >
> > > > Add EDMA support no-ll mode is quite easily in future.
> > > >
> > >
> > > This looks reasonable provided that HDMA got the support for this param.
> > > An error check can be added in the next revision.
> > > The addition may be slightly different as following:
> > > If (chan->dw->chip->mf == EDMA_MF_HDMA_NATIVE) { ...
> > > } else if (config->peripheral_config) {
> > >  /* error handling */
> > > }
> > >
> > > Using the above, if support needs to be added to EDMA then a check for
> > correct 'mf'
> > > in the if() shall be sufficient.
> > >
> > > > >
> > > > > > > +             if (config->peripheral_config &&
> > > > > > > +                 config->peripheral_size != sizeof(int)) {
> > > > > > > +                     dev_err(dchan->device->dev,
> > > > > > > +                             "config param peripheral size mismatch\n");
> > > > > > > +                     return -EINVAL;
> > > > > > > +             }
> > > > > > > +
> > > > > > > +             /*
> > > > > > > +              * When there is no valid LLP base address available then
> > the
> > > > > > > +              * default DMA ops will use the non-LL mode.
> > > > > > > +              *
> > > > > > > +              * Cases where LL mode is enabled and client wants to use
> > the
> > > > > > > +              * non-LL mode then also client can do so via providing the
> > > > > > > +              * peripheral_config param.
> > > > > > > +              */
> > > > > > > +             if (config->peripheral_config)
> > > > > > > +                     non_ll = *(int
> > > > > > > + *)config->peripheral_config;
> > > > > > > +
> > > > > > > +             if (chan->dw->chip->non_ll ||
> > > > > > > + (!chan->dw->chip->non_ll && non_ll))
> > > > > >
> > > > > > if chan->dw->chip->non_ll is true, It should return error if you
> > > > > > set non_ll false because no LLP base available.
> > > > > >
> > > > >
> > > > > In case the 'chan->dw->chip->non_ll' is true, then the default
> > > > >mode  becomes non-LL for HDMA ONLY. There is no option to the user
> > > > >to  configure the LL mode by giving 'non_ll = false' as part of the
> > > > >config- peripheral_config.
> > > >
> > > > This is API's callback, you can't assume caller do all correct things.
> > > >
> > > > > The configuration of default non-LL mode depends on how the IP is
> > > > > programmed by the user. The user is aware of the IP configuration.
> > > >
> > > > It is not true. DMA consumer don't know such detail information,
> > > > which only know which dma engineer providor.
> > > >
> > >
> > > For the DMA consumer the only option is LL mode as default mode. In
> > > order to use the non-LL mode it need to provide the parameter in the form
> > of peripheral_config.
> > > Given the above statement, the consumer even if gives the 'non_ll =
> > > false', it is not going to change any behavior.
> > > Even if the user is not giving the option the assumption is that
> > > controller is in LL mode, unless the DMA engine provider provides the
> > > information regarding non-LL mode as default mode to the DMA consumer
> > explicitly.
> > > In the case where chan->dw->chip->non_ll = true, following case may
> > happen:
> > > - DMA consumer provides no peripheral_config param or simply config-
> > >peripheral_config = NULL,
> > >    in this case non_ll = false which is the current flow.
> > > - DMA consumer provides a valid peripheral_config (!= NULL) param but the
> > value is '0', in this case
> > >   It is explicit but it would have the same effect as above case.
> > >
> > > DMA consumer is supposed to provide the only option non_ll as it was
> > > not available and LL mode is set as default for the DMA operations.
> > > When 'chan->dw->chip->non_ll = true' then this was added to make the
> > > chip usable when the LLP base addresses are not configured. Without
> > > this, user cannot use any of the modes be it LL or non-LL if the LLP base
> > address is not configured.
> >
> > little bit confuse, Maybe the same as you. I expected behavor
> >
> > config->peripheral_config = NULL        choose hardware default one
> >                                         -           LL mode if hardware support
> >                                         -      none-LL mode if not ll list region
> >
> > config->peripheral_config != NULL
> > EDMA: return false
> > HDMA:
> >                 0                       force to none_ll mode. (always success)
> >                 1                       force back to ll mode  (return false if no ll list region in
> > chip)
> >
> > DMA consumer decide if fall back to none_ll to continue.
> >
>
> Thank you for the elaboration!
> I have few questions, why shall a DMA consumer decide to enable LL mode when the
> default mode supported is LL mode only?

LL mode only is software driver implement. Hardware support both LL mode
and no-LL mode. Previous driver implement only support LL mode. You try
to add non-LL mode. Choose straightforward forward method.

One indicate hardware capacity,  one actually used. Like PCI INTX and MSI.
If support MSI, most case use MSI. But still support switch to use INTX.

My key point avoid hidden beavior. Every branch is clean and
straightforward.

>
> If DMA consumer is trying to enable the LL mode, then one must be knowing the configuration
> of the controller that controller is working in non-LL mode,
> as LLP base address is not configured,then why to try and enable the LL mode?

The DMA consumer don't know these informaiton.

>
> The user need to know, at least, one detail from the above two cases.
>
> The use for non-LL mode is useful in the following scenario:
> - When user want to utilize the LL regions also for DMA data transfers.
> - For single and big chunks non-LL mode is useful in both use-cases when non-LL mode is default or
>   user enables it via peripheral_config params.
> - This addition, inadvertently, makes the DMA controller usable, for AMD (Xilinx) only, when the LLP
>   base addresses are not configured; it can be used in non-LL mode.

LL regions may not visiable,  User can use non-ll to config LL-region and
switch back to use LL-region to continue transfer. User may use non-ll
as indirectly reg access.

> For Synopsys, DMA controller
>   cannot be used in any mode if LLP base address is not configured.

Does spec said it? It doesn't make sense. it should be controlled by LLE
of DMA_CH_CONTROL1_OFF_RDCH_0.

>
> Based on the above points, if user is trying to enable LL mode when default mode is LL mode, it looks
> Intentionally making the choice when user is aware of the mode DMA controller operating in.
> Please let me know if this clarifies the doubt.

No API to get mode, only use set and test to know it.

Actually Needn't consider so complex. like functions API(x)

We just consider input x,

	validate x's input ragion,

	if x is out of region, just return error.

>
> > >
> > > > > The check for non-LL option
> > > > > provided by the user is useful when LL-mode is default. That is
> > > > > why the value of non_ll == false is not even evaluated.
> > > > >
> > > > > > > +                     chan->non_ll = true;
> > > > > > > +     }
> > > > > > >
> > > > ...
> > > > > > > diff --git a/include/linux/dma/edma.h
> > > > > > > b/include/linux/dma/edma.h index 3080747689f6..78ce31b049ae
> > > > > > > 100644
> > > > > > > --- a/include/linux/dma/edma.h
> > > > > > > +++ b/include/linux/dma/edma.h
> > > > > > > @@ -99,6 +99,7 @@ struct dw_edma_chip {
> > > > > > >       enum dw_edma_map_format mf;
> > > > > > >
> > > > > > >       struct dw_edma          *dw;
> > > > > > > +     bool                    non_ll;
> > > > > >
> > > > > > Can you check ll_region directly? it should be equal to
> > > > > > (ll_region->sz == 0)
> > > > ?
> > > >
> > > > Do you miss this questin?
> > > >
> > > > Frank
> > > >
> > >
> > > Yes, looks like I missed this question. Could you explain a little bit more? I
> > am unable to understand the context.
> >
> > you set chip->non_ll = non_ll in dw_edma_pcie_probe()
> >
> > and only set ll_region->sz = ll_block->sz when !chip->non_ll.
> >
> > Thats means ll_region->sz is 0 when chip->non_ll is true.
> >
> > So non_ll have not bring new infomation into dw_edma_chip.
> >
> > check !ll_region->sz, which should be equal to this non_ll.
> >
> > dw_edma_chip is the exchange information between controller and dma core
> > driver. Needn't cache it here because you already save a copy in dma-chan.
> >
> > Frank
>
> I understand the concern here but it does not look good to piggyback the
> non_ll related information on the existing variable.
> The use of bool readily points out the information related to what mode is being intended
> but using the ll_region->sz is an inference the user has to make.
>
> Having ll_region->sz == 0 does not really tell it is non_ll mode or not, it can also mean that
> the size of LL region is zero while in LL mode which could be an error.
> This does not translate to support for non-LL mode. This brings the ambiguity.
> The introduction of the non_ll provides clarity and easy comparison with the similar
> choice (non_ll) provided by the DMA consumer in the dmaengine_slave_config().
> I request we shall retain the clarity here.

You can use helper(dw_chip_is_support_ll()) macro to check chip's capatiblity.

Frank
>
> > >
> > > > > >
> > > > > > Frank
> > > > > > >  };
> > > > > > >
> > > > > > >  /* Export to the platform drivers */
> > > > > > > --
> > > > > > > 2.43.0
> > > > > > >

