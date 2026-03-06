Return-Path: <dmaengine+bounces-9309-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIunCINAq2mdbgEAu9opvQ
	(envelope-from <dmaengine+bounces-9309-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Mar 2026 22:00:51 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC96227AE8
	for <lists+dmaengine@lfdr.de>; Fri, 06 Mar 2026 22:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EE1C3051D07
	for <lists+dmaengine@lfdr.de>; Fri,  6 Mar 2026 21:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3C337A488;
	Fri,  6 Mar 2026 21:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GYcHLEHf"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013033.outbound.protection.outlook.com [52.101.72.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56500481679;
	Fri,  6 Mar 2026 21:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772830811; cv=fail; b=dhlitHw64kDvgMwpZ+79TDSWyG97Eiqkkm2GA2UHffnm1S41RdKAvVo1uME/yN8hsR415xIPBfeW6lrr6VJvsKOeQZ+bhZmZWUHU1kSieBycJUkdG42H7Tupc81SRRX2LXCtKtB8QL3BmtTruobLeyplpAPWGrlHWtAyzKKyimg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772830811; c=relaxed/simple;
	bh=PXQLKrBWNvWh6ksIAUk/0eaOPQw7Hx7ObNiLZWXPepo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sWQIcGB4mmjA0GUl0vcYJJUiHgHczffe7QpV+u6bxt5/1ZQM3gYE+JsYcU7YbDnRTel656megBULUC44R2AW6eBieScPEO1W7gTdtVlV77dEsKDi7eZfTUEF/ri7lioomlAXQdD2OL0W+FcCCjLfAvLQOl3wI7jdqvac59/jwA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GYcHLEHf; arc=fail smtp.client-ip=52.101.72.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l57DehaZgEfNuLzJVkHMuX+AVzwBn8ozIAG1MWcsP+NQ3bC82Say+Ew2SiSOPziiqit5qCK434UMxBbXZ9KS+DxkoljM/EcIBlVX0bAKCGI/n63T316yuPc2RdWy9KLhrZzecBREZH8G5glIILGkpjzPnpcGpsrBPlaKKB+ThweGjG4QMJ2vUfXA1MOGaFDUJdSTPzjXjPWwETm5H3YZhU5b+d4Ex2+axQdjoJfgtxQcxofHVEzmwMXZ1N0LGzjgIF0vMJ8cWcjPglGeBdOXKDqxKQBpCDPA+HtxOdbw5zh22Xexpl+H46mKw4EXOUAg6vtrq9VvZm5osGTNDj33vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxlWkC+3g9Z1vJF9myYPqRc41n1WhMz537HbYh2MeT0=;
 b=dUrj0JXXUe/Shhhp+0C0sXh4Sb5s2M1kHjsuBRr2YL6MTBx6Q1qn5gyo8DjKS7E0l57YN9cGTkNrSNodBoJxPU93YMavKm7KK02mOkxc5QlVSAN2YJOdc9HkB1s/6Mons+lx858IKTFxDQRFmhZ9MWQ56Zgnh2aeQRPG9kvMma4qmC93iOOOQEsAoCh/rkx4nDhzaAFfcrk4bbXQ+bIjzAhFJk+sdKMM7F6wpa4Eobb/1vVqi1gE+1iakQPSEK5VfxmSeDXkZPOwg2IBxZ2pIk/NAmYSozTr18qpWuSUBGa9sWxqix6cb0lgKFSIrG0aIkfxYa2KalvT89OE5Essvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxlWkC+3g9Z1vJF9myYPqRc41n1WhMz537HbYh2MeT0=;
 b=GYcHLEHffylJzB1dEyBe3Ou2ZEQVXRpEJ3xdQKZh0iCiG1PygsOpW0ILIAFE3VXbz+LtUc1yVDpxDP6foIfsr6cqCM0HzM+x402QoHiwn7QDfpeb+Wu9zyWunqz0YWeuUlcUdqmjChmGkvbGNrGjRzony1a4sTNfpXR+bwinOWay135GR6dDaB2ajaalVv+DVI9HRDvHUauKmF/DlhD+ZIl/gvPTPtoZ2cKlloKsjkDqB7xewLrSHaZYG5IrE2mxmvRg+/syiQFQGGcplk2gJ++7c8HRIcV7Wb2Bow6S7wVeg2sDua3WzJTD60KI4AiC5gksA7K3CTsrgp3bSjIn7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GV1PR04MB11515.eurprd04.prod.outlook.com (2603:10a6:150:284::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.19; Fri, 6 Mar
 2026 21:00:05 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 21:00:05 +0000
Date: Fri, 6 Mar 2026 15:59:57 -0500
From: Frank Li <Frank.li@nxp.com>
To: Devendra K Verma <devendra.verma@amd.com>
Cc: bhelgaas@google.com, mani@kernel.org, vkoul@kernel.org,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.simek@amd.com
Subject: Re: [PATCH v11 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint Support
Message-ID: <aatATZcsxrISkcF5@lizhi-Precision-Tower-5810>
References: <20260306115228.3446528-1-devendra.verma@amd.com>
 <20260306115228.3446528-2-devendra.verma@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306115228.3446528-2-devendra.verma@amd.com>
X-ClientProxiedBy: PH5P222CA0012.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::8) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GV1PR04MB11515:EE_
X-MS-Office365-Filtering-Correlation-Id: f557a390-46a6-48ee-014b-08de7bc357b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|19092799006|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	5hEv/FmcxJhRDIwZk4OaKv0t9knrnH96RoZVLH9/wyW1SRLF02XDBbx2mqezQeggP1NnZcXsj0uCV9HG8AOQP9QuO+/T9wxLM1O5Z6jyuB6aDxo7wd+JEnRhhtaag7qcNAoGYN/lXxewpYh9awBSsMr+B8uGaY2942Dmsh/pi18X0YppkqBj/xHa584/BfUWF81H0FrTezEzUTcbNAlm+at8xwgGcRAzCBx6ds/6xpdoDE92oNYcIvsfHgDlsmwNmrSWkhr6bu8NopUi0OUSUSi2f30wd302KIojaNJGtrye672elV79OAFEMA/zHRENIZ195jAD5XTgbEwcs0EWdXw7oK/SIGpRPa/Hx1fN+lqlIJrifPZO4B6CxS+uAVg6zP4I/4vai/amXfCxa0Wci7N2X5zn69g1YrF1tKA97suYliDW35tabTOTAAQzxYratvjzEFsNM2k8aRUon+BNefSweuqF2vVLSkj2l1BJlyYNsZlDDAjskB91BDhBrCfX7tifZBOWqV8z32+3+MF2fat6D2Vuv1GVEQHCXWrSB3UMphQgzN6FDBdkqnpsJb3BGtLgc9nyQGUO1d2ojXLs81I6sbcXLSGW/1GvOyGwGQTgdBB0A5S33RE0Gvpd6aF5lRTbROFmFUslkJPpXapxzkICeXpnfx1APOD8olvC/DcXGCJyHmZyK00bTFyA6QM0bXk1DzDIrLG5u8G6zpIjnMhumL52uQSPxKhEZqOfvBAXIdRWcuqpLV8Mg12BMglqd56Tf4lzUxDYo0ItdgHQF1OtiXMrZcMsV+RHNzAYBUU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(19092799006)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t9yAWxQ0TbYlfdHR+d45z35L45DwC1ELT2fBDlRLYfArWEoF7IHHRs7lF6uX?=
 =?us-ascii?Q?8eREroIDTk0mnNDUkRtgb5Tpgtg99xpae3HbE4vjPlx2oPGQbzb6IoMfYpSO?=
 =?us-ascii?Q?tDENoq4yigtnA2NCsxxPOqWLGjI3RjdRWQIT5iz52julS4cuBWueIcQVBsw1?=
 =?us-ascii?Q?v+zoaVc1jRejSYMPbpQvloNdLGaCMeJfqXDd9wK/n9FRTGDEnIg4eANwL8oP?=
 =?us-ascii?Q?PIy72t9N7mVOnJfKgAcNWgq+WJeImS44L17sXxXqzBnYXXVBR/Qy4sS/cglZ?=
 =?us-ascii?Q?/gGIBHKpzZhQSyXy+dSL73s4F5WrlFsr6VxTFZt3CEholSmMMzMcTgSFgIdV?=
 =?us-ascii?Q?lsD/HTs7o7ioRdZVYYQw+10edmXTkX0l/MKh1EdrxE2j46ghJ7aTvaKk1+YG?=
 =?us-ascii?Q?4zatSt4K3MsjPPFXWI9kYoRsFJnk6mFdoG0q9GbM3B0latqaPUOg4nBPvxMp?=
 =?us-ascii?Q?4kfACDyxZOuObxo8cizWRVOjOFrDGgxNybyYxFQwl1cIkuwaBtwVAkyjNjxY?=
 =?us-ascii?Q?A9FETi+WmFzOZ7Uq60366q21zyhASTTdtq4bRTZjj2h5yq83FMDvVvYSXJCx?=
 =?us-ascii?Q?El7C4HX9B3/kOtxUMvNcXuqFrhhsKVA8mB4NnPF/ZNAGZUFiKyg5VXinBMS0?=
 =?us-ascii?Q?Egvv9OBxTyvmqCGZcHrEvzNjJLwcSidF67ZFNTwbCJA5AIG49ciYckbg0xgV?=
 =?us-ascii?Q?DNYBzCyk+MrIjsUnedMHXXpBsGpwYR5opH+k6JdtV1hl8MDwHqUIxyfID0uP?=
 =?us-ascii?Q?mDnMyVLivMF7WlkMVIEpL1E8CUxaRmTcxUWErELve3Ak1eJbM5NU1EY2PvRS?=
 =?us-ascii?Q?ZQHEyIJ62CEYcrVHzSN5Xn1702pn5zl5Vlz4C5fWPQZHBlLuBxAQSeASNoA8?=
 =?us-ascii?Q?FsgHyF8QYB0gDmg8LrIWtRWSGLe1yM3eGUDOw53qdMcMn9rF5hE4KBSpZVjX?=
 =?us-ascii?Q?Z8hOjlZedYgDyqvHwp5DqI2PMI0QvuZNQuzWN4HDdRBnnfHDGrETa4LVMCsV?=
 =?us-ascii?Q?vVWNdKIHx6Y5I7tnylcH/AzWp8CVQ8kIfmqs6z31MematwBcl3UVmN7pmcuU?=
 =?us-ascii?Q?MlgRLWZIDMHrhEGgPFqsqzt7i4W55+MdTwO7wHOspyZeRk3UicmkQsvFWrQH?=
 =?us-ascii?Q?YRmN60JnCeXpKMnd49Ql6rGhUXd5yob36iWmtk31UEQ9GUecWaZsYlqnspNG?=
 =?us-ascii?Q?7SpNiijQHjSc+TiG9fte5jvqpohZ3+dJ3rxpXshe2jm6l23LnzkII+Uymg+T?=
 =?us-ascii?Q?oHZDfaa1j1yQ5mI+STn/nwf2SA5PbZt6uZFgTz//chs0fAkESSGuDYjPmFul?=
 =?us-ascii?Q?naBVteaE6pC5cpuR7ymWjUaLrcTBHOGYn70BI9wq4yKlEGbyjlF1Db2n/dOt?=
 =?us-ascii?Q?RPyWzYrnWQ7/2UZuzh66WKiQhD+K3dtUvobdz/rzyqw1x27DrEiha1fhx8Ge?=
 =?us-ascii?Q?ijTs2iSZaPQw972hKUkLvVakp0j5Bb1Af7ZDSZQhHMWcJI6vH70Z4ldZJbM5?=
 =?us-ascii?Q?AFKgQBar+ATFM87IQT5QHV3yT69f9zFDkoXFGXiuhEbtdicB5jeav1iNJDUs?=
 =?us-ascii?Q?Vk/6oMHJq+t1djgQqb958zVXYBVAjcKutgEqKh9xoek9B06zolfnJ9JpSMeb?=
 =?us-ascii?Q?IWm4zkwzj0mjpJnZQbx0GSCSt9U1QeQUFtlkAXPlo82bJWHX0yt+YZjtiA81?=
 =?us-ascii?Q?3gAFS3m5RD+8mmxP8ApYyBWciKm98EWtIhf3xxesUkyhmItTuvWdMA7dPwwU?=
 =?us-ascii?Q?QhLaqNZFGQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f557a390-46a6-48ee-014b-08de7bc357b6
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 21:00:05.5742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WImBfceieOiL6P+n/UbKTSckDIkB9sb46ZHVgc+v4KOGjXLgoRIHdKC4S7T6nHOP0ACjbgMYvnToLdBtrNhpjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11515
X-Rspamd-Queue-Id: BDC96227AE8
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
	TAGGED_FROM(0.00)[bounces-9309-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.954];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:dkim,nxp.com:email]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 05:22:27PM +0530, Devendra K Verma wrote:
> AMD MDB PCIe endpoint support. For AMD specific support
> added the following
>   - AMD supported PCIe Device IDs and Vendor ID (Xilinx).
>   - AMD MDB specific driver data
>   - AMD MDB specific VSEC capability to retrieve the device DDR
>     base address.
>
> Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Changes in v11:
> Replaced min_t() function with min().
>
> Changes in v10:
> For Xilinx VSEC function kept only HDMA map format as
> Xilinx only supports HDMA.
>
> Changes in v9:
> Moved Xilinx specific VSEC capability functions under
> the vendor ID condition.
>
> Changes in v8:
> Changed the contant names to includer product vendor.
> Moved the vendor specific code to vendor specific functions.
>
> Changes in v7:
> Introduced vendor specific functions to retrieve the
> vsec data.
>
> Changes in v6:
> Included "sizes.h" header and used the appropriate
> definitions instead of constants.
>
> Changes in v5:
> Added the definitions for Xilinx specific VSEC header id,
> revision, and register offsets.
> Corrected the error type when no physical offset found for
> device side memory.
> Corrected the order of variables.
>
> Changes in v4:
> Configured 8 read and 8 write channels for Xilinx vendor
> Added checks to validate vendor ID for vendor
> specific vsec id.
> Added Xilinx specific vendor id for vsec specific to Xilinx
> Added the LL and data region offsets, size as input params to
> function dw_edma_set_chan_region_offset().
> Moved the LL and data region offsets assignment to function
> for Xilinx specific case.
> Corrected comments.
>
> Changes in v3:
> Corrected a typo when assigning AMD (Xilinx) vsec id macro
> and condition check.
>
> Changes in v2:
> Reverted the devmem_phys_off type to u64.
> Renamed the function appropriately to suit the
> functionality for setting the LL & data region offsets.
>
> Changes in v1:
> Removed the pci device id from pci_ids.h file.
> Added the vendor id macro as per the suggested method.
> Changed the type of the newly added devmem_phys_off variable.
> Added to logic to assign offsets for LL and data region blocks
> in case more number of channels are enabled than given in
> amd_mdb_data struct.
> ---
>  drivers/dma/dw-edma/dw-edma-pcie.c | 190 ++++++++++++++++++++++++++---
>  1 file changed, 176 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 3371e0a76d3c..b8208186a250 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -14,14 +14,35 @@
>  #include <linux/pci-epf.h>
>  #include <linux/msi.h>
>  #include <linux/bitfield.h>
> +#include <linux/sizes.h>
>
>  #include "dw-edma-core.h"
>
> -#define DW_PCIE_VSEC_DMA_ID			0x6
> -#define DW_PCIE_VSEC_DMA_BAR			GENMASK(10, 8)
> -#define DW_PCIE_VSEC_DMA_MAP			GENMASK(2, 0)
> -#define DW_PCIE_VSEC_DMA_WR_CH			GENMASK(9, 0)
> -#define DW_PCIE_VSEC_DMA_RD_CH			GENMASK(25, 16)
> +/* Synopsys */
> +#define DW_PCIE_SYNOPSYS_VSEC_DMA_ID		0x6
> +#define DW_PCIE_SYNOPSYS_VSEC_DMA_BAR		GENMASK(10, 8)
> +#define DW_PCIE_SYNOPSYS_VSEC_DMA_MAP		GENMASK(2, 0)
> +#define DW_PCIE_SYNOPSYS_VSEC_DMA_WR_CH		GENMASK(9, 0)
> +#define DW_PCIE_SYNOPSYS_VSEC_DMA_RD_CH		GENMASK(25, 16)
> +
> +/* AMD MDB (Xilinx) specific defines */
> +#define PCI_DEVICE_ID_XILINX_B054		0xb054
> +
> +#define DW_PCIE_XILINX_MDB_VSEC_DMA_ID		0x6
> +#define DW_PCIE_XILINX_MDB_VSEC_ID		0x20
> +#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
> +#define DW_PCIE_XILINX_MDB_VSEC_DMA_MAP		GENMASK(2, 0)
> +#define DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH	GENMASK(9, 0)
> +#define DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH	GENMASK(25, 16)
> +
> +#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH	0xc
> +#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW	0x8
> +#define DW_PCIE_XILINX_MDB_INVALID_ADDR		(~0ULL)
> +
> +#define DW_PCIE_XILINX_MDB_LL_OFF_GAP		0x200000
> +#define DW_PCIE_XILINX_MDB_LL_SIZE		0x800
> +#define DW_PCIE_XILINX_MDB_DT_OFF_GAP		0x100000
> +#define DW_PCIE_XILINX_MDB_DT_SIZE		0x800
>
>  #define DW_BLOCK(a, b, c) \
>  	{ \
> @@ -50,6 +71,7 @@ struct dw_edma_pcie_data {
>  	u8				irqs;
>  	u16				wr_ch_cnt;
>  	u16				rd_ch_cnt;
> +	u64				devmem_phys_off;
>  };
>
>  static const struct dw_edma_pcie_data snps_edda_data = {
> @@ -90,6 +112,64 @@ static const struct dw_edma_pcie_data snps_edda_data = {
>  	.rd_ch_cnt			= 2,
>  };
>
> +static const struct dw_edma_pcie_data xilinx_mdb_data = {
> +	/* MDB registers location */
> +	.rg.bar				= BAR_0,
> +	.rg.off				= SZ_4K,	/*  4 Kbytes */
> +	.rg.sz				= SZ_8K,	/*  8 Kbytes */
> +
> +	/* Other */
> +	.mf				= EDMA_MF_HDMA_NATIVE,
> +	.irqs				= 1,
> +	.wr_ch_cnt			= 8,
> +	.rd_ch_cnt			= 8,
> +};
> +
> +static void dw_edma_set_chan_region_offset(struct dw_edma_pcie_data *pdata,
> +					   enum pci_barno bar, off_t start_off,
> +					   off_t ll_off_gap, size_t ll_size,
> +					   off_t dt_off_gap, size_t dt_size)
> +{
> +	u16 wr_ch = pdata->wr_ch_cnt;
> +	u16 rd_ch = pdata->rd_ch_cnt;
> +	off_t off;
> +	u16 i;
> +
> +	off = start_off;
> +
> +	/* Write channel LL region */
> +	for (i = 0; i < wr_ch; i++) {
> +		pdata->ll_wr[i].bar = bar;
> +		pdata->ll_wr[i].off = off;
> +		pdata->ll_wr[i].sz = ll_size;
> +		off += ll_off_gap;
> +	}
> +
> +	/* Read channel LL region */
> +	for (i = 0; i < rd_ch; i++) {
> +		pdata->ll_rd[i].bar = bar;
> +		pdata->ll_rd[i].off = off;
> +		pdata->ll_rd[i].sz = ll_size;
> +		off += ll_off_gap;
> +	}
> +
> +	/* Write channel data region */
> +	for (i = 0; i < wr_ch; i++) {
> +		pdata->dt_wr[i].bar = bar;
> +		pdata->dt_wr[i].off = off;
> +		pdata->dt_wr[i].sz = dt_size;
> +		off += dt_off_gap;
> +	}
> +
> +	/* Read channel data region */
> +	for (i = 0; i < rd_ch; i++) {
> +		pdata->dt_rd[i].bar = bar;
> +		pdata->dt_rd[i].off = off;
> +		pdata->dt_rd[i].sz = dt_size;
> +		off += dt_off_gap;
> +	}
> +}
> +
>  static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int nr)
>  {
>  	return pci_irq_vector(to_pci_dev(dev), nr);
> @@ -114,15 +194,15 @@ static const struct dw_edma_plat_ops dw_edma_pcie_plat_ops = {
>  	.pci_address = dw_edma_pcie_address,
>  };
>
> -static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
> -					   struct dw_edma_pcie_data *pdata)
> +static void dw_edma_pcie_get_synopsys_dma_data(struct pci_dev *pdev,
> +					       struct dw_edma_pcie_data *pdata)
>  {
>  	u32 val, map;
>  	u16 vsec;
>  	u64 off;
>
>  	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_SYNOPSYS,
> -					DW_PCIE_VSEC_DMA_ID);
> +					DW_PCIE_SYNOPSYS_VSEC_DMA_ID);
>  	if (!vsec)
>  		return;
>
> @@ -131,9 +211,9 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
>  	    PCI_VNDR_HEADER_LEN(val) != 0x18)
>  		return;
>
> -	pci_dbg(pdev, "Detected PCIe Vendor-Specific Extended Capability DMA\n");
> +	pci_dbg(pdev, "Detected Synopsys PCIe Vendor-Specific Extended Capability DMA\n");
>  	pci_read_config_dword(pdev, vsec + 0x8, &val);
> -	map = FIELD_GET(DW_PCIE_VSEC_DMA_MAP, val);
> +	map = FIELD_GET(DW_PCIE_SYNOPSYS_VSEC_DMA_MAP, val);
>  	if (map != EDMA_MF_EDMA_LEGACY &&
>  	    map != EDMA_MF_EDMA_UNROLL &&
>  	    map != EDMA_MF_HDMA_COMPAT &&
> @@ -141,13 +221,13 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
>  		return;
>
>  	pdata->mf = map;
> -	pdata->rg.bar = FIELD_GET(DW_PCIE_VSEC_DMA_BAR, val);
> +	pdata->rg.bar = FIELD_GET(DW_PCIE_SYNOPSYS_VSEC_DMA_BAR, val);
>
>  	pci_read_config_dword(pdev, vsec + 0xc, &val);
>  	pdata->wr_ch_cnt = min_t(u16, pdata->wr_ch_cnt,
> -				 FIELD_GET(DW_PCIE_VSEC_DMA_WR_CH, val));
> +				 FIELD_GET(DW_PCIE_SYNOPSYS_VSEC_DMA_WR_CH, val));
>  	pdata->rd_ch_cnt = min_t(u16, pdata->rd_ch_cnt,
> -				 FIELD_GET(DW_PCIE_VSEC_DMA_RD_CH, val));
> +				 FIELD_GET(DW_PCIE_SYNOPSYS_VSEC_DMA_RD_CH, val));
>
>  	pci_read_config_dword(pdev, vsec + 0x14, &val);
>  	off = val;
> @@ -157,6 +237,64 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
>  	pdata->rg.off = off;
>  }
>
> +static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
> +					     struct dw_edma_pcie_data *pdata)
> +{
> +	u32 val, map;
> +	u16 vsec;
> +	u64 off;
> +
> +	pdata->devmem_phys_off = DW_PCIE_XILINX_MDB_INVALID_ADDR;
> +
> +	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
> +					DW_PCIE_XILINX_MDB_VSEC_DMA_ID);
> +	if (!vsec)
> +		return;
> +
> +	pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER, &val);
> +	if (PCI_VNDR_HEADER_REV(val) != 0x00 ||
> +	    PCI_VNDR_HEADER_LEN(val) != 0x18)
> +		return;
> +
> +	pci_dbg(pdev, "Detected Xilinx PCIe Vendor-Specific Extended Capability DMA\n");
> +	pci_read_config_dword(pdev, vsec + 0x8, &val);
> +	map = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_MAP, val);
> +	if (map != EDMA_MF_HDMA_NATIVE)
> +		return;
> +
> +	pdata->mf = map;
> +	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_BAR, val);
> +
> +	pci_read_config_dword(pdev, vsec + 0xc, &val);
> +	pdata->wr_ch_cnt = min(pdata->wr_ch_cnt,
> +			       FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH, val));
> +	pdata->rd_ch_cnt = min(pdata->rd_ch_cnt,
> +			       FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH, val));
> +
> +	pci_read_config_dword(pdev, vsec + 0x14, &val);
> +	off = val;
> +	pci_read_config_dword(pdev, vsec + 0x10, &val);
> +	off <<= 32;
> +	off |= val;
> +	pdata->rg.off = off;
> +
> +	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
> +					DW_PCIE_XILINX_MDB_VSEC_ID);
> +	if (!vsec)
> +		return;
> +
> +	pci_read_config_dword(pdev,
> +			      vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH,
> +			      &val);
> +	off = val;
> +	pci_read_config_dword(pdev,
> +			      vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW,
> +			      &val);
> +	off <<= 32;
> +	off |= val;
> +	pdata->devmem_phys_off = off;
> +}
> +
>  static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  			      const struct pci_device_id *pid)
>  {
> @@ -184,7 +322,29 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	 * Tries to find if exists a PCIe Vendor-Specific Extended Capability
>  	 * for the DMA, if one exists, then reconfigures it.
>  	 */
> -	dw_edma_pcie_get_vsec_dma_data(pdev, vsec_data);
> +	dw_edma_pcie_get_synopsys_dma_data(pdev, vsec_data);
> +
> +	if (pdev->vendor == PCI_VENDOR_ID_XILINX) {
> +		dw_edma_pcie_get_xilinx_dma_data(pdev, vsec_data);
> +
> +		/*
> +		 * There is no valid address found for the LL memory
> +		 * space on the device side.
> +		 */
> +		if (vsec_data->devmem_phys_off == DW_PCIE_XILINX_MDB_INVALID_ADDR)
> +			return -ENOMEM;
> +
> +		/*
> +		 * Configure the channel LL and data blocks if number of
> +		 * channels enabled in VSEC capability are more than the
> +		 * channels configured in xilinx_mdb_data.
> +		 */
> +		dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
> +					       DW_PCIE_XILINX_MDB_LL_OFF_GAP,
> +					       DW_PCIE_XILINX_MDB_LL_SIZE,
> +					       DW_PCIE_XILINX_MDB_DT_OFF_GAP,
> +					       DW_PCIE_XILINX_MDB_DT_SIZE);
> +	}
>
>  	/* Mapping PCI BAR regions */
>  	mask = BIT(vsec_data->rg.bar);
> @@ -367,6 +527,8 @@ static void dw_edma_pcie_remove(struct pci_dev *pdev)
>
>  static const struct pci_device_id dw_edma_pcie_id_table[] = {
>  	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
> +	{ PCI_VDEVICE(XILINX, PCI_DEVICE_ID_XILINX_B054),
> +	  (kernel_ulong_t)&xilinx_mdb_data },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
> --
> 2.43.0
>

