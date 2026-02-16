Return-Path: <dmaengine+bounces-8912-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPRVCc1Ik2mi3AEAu9opvQ
	(envelope-from <dmaengine+bounces-8912-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 16 Feb 2026 17:41:49 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 739501464A9
	for <lists+dmaengine@lfdr.de>; Mon, 16 Feb 2026 17:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7ED8303CE9D
	for <lists+dmaengine@lfdr.de>; Mon, 16 Feb 2026 16:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561D6328B44;
	Mon, 16 Feb 2026 16:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EFAOFV6F"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013026.outbound.protection.outlook.com [40.107.162.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64223321D4;
	Mon, 16 Feb 2026 16:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771259949; cv=fail; b=cfNhk6c2ma0Il2BKT2qrZsis4Z431bzTvj/84dg5iqpiaISEV4lK+wUcMHsV2Y7NGtzUlDCftMR7xLMwQ674VJZAMFZNGp1/SV3KDLg73sA60sn9ylWNHMYEbUyUqoB8w41B5ErxLmM5GKIYWPPSeZz6f5HUy9kUOtybN2sE+3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771259949; c=relaxed/simple;
	bh=p9Ja+Uw2fm5n1BMY2rKhTZwQY6OsenNYgE+4qRONRXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gc0Up8Hw7p777iretLHBm284mjwZo9iL7rWVx/w1DQpV3LJJFK+faOSsBZsKtVxf2iWDOm6JCxStgBvufKlWMJsPbnt3svBxveumjCB0bwFbohmbvi3EKF9P/xikoWpZujC2Vvl6q9qiUuddth8MfpsU8Q4skvxBF+QkOPNvH8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EFAOFV6F; arc=fail smtp.client-ip=40.107.162.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6Co7WGZEecT5OlQ2/cszi4TTXVFQjkHR6tdjiCYDobMIxXBeEJr4VLgCW7b1epZDATYP/0td/sE1Lug2dpgE5JuTM1gGBNAWGwOaVBD9+IfJvgXE4uYaCl9w/BEaUOBNnRl8jpIbsInkhaCsx/oz+mz7ShGecYIaZ7rWdltcgspn43q4b/36ow7bZ8pQ+M8HfN7cY+SNwtP09s91wfWTzumGAZ7X4jLeL/VGqV4LmlSpT4JpEU7iYA1qSPOfivJ+1PVtWudweKh3P/HPmLuESVHTeLbhIbtzabZ5L7dJcIfB+juNU0Jpg+jVUZlJaCEB4t19/1wN6PnLPbaPgKoeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBG5rTeCnIKidOCr200onFRYqplHoElwz7VRAMsneAY=;
 b=Y3Lzss/Fo8PmPMQq/tkJg2+Hiwt+MyEArx4ETVgYY7DkqpkMTSfyB2CiEOaV/IMyUms9kfdmgqQ+jMTGCVbMFYutVi26CgGWm95FHVGC3+Ndsj+SrM1K0d7IBcpcF3Lp5gXFeFZM4l3x4rZvI7bp09gEebcM0ceNYN0rwgfmLcsfOG9Wyo0/KiDU5WeSXFGM/e3qwU4SIyEBAJDXFuziZXpjfPc7xAIzJn28dwuLn4djFhC63a5LszkGVHGSqmadFmMpR6nrzLTf60+g/e3PRfWdZdaP4CwevxiCjYZPTCbSWbqRC/ZiaTRqX56u+nTJEFVyklHnyZ7Wh0FAYoakxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBG5rTeCnIKidOCr200onFRYqplHoElwz7VRAMsneAY=;
 b=EFAOFV6FE+ZyaekRZt11rqpijpq+uADe2SQTAFzj75mxof74ih6j2UvcRFMHalEnDXWBs99tY7EQOoz/rZItHhwJnyJfsHhuWHVor73hkoKiE3Zur17ziSX1Gwv+6DGUCfZXPZrPuK55Pf+yu0cWC3f9aL5Ip/axTvYSLzhRBx8mLXRdUjKs0lON2VBay/AbCL1x/rmhB/6MbpH6KtK7u+OFWe/S75dSTQRXyhD8ebWnGRHOPlMZjoPE9AsPnoLrjOmw12AV3veXwaFjobMssas1KTdzD3LqKPg21SWoPPONdo3SItLmcxX+1ZF1Unz9jbJC0CV2HIvUhlJVmhaCRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM0PR04MB7011.eurprd04.prod.outlook.com (2603:10a6:208:193::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 16:39:05 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 16:39:05 +0000
Date: Mon, 16 Feb 2026 11:38:58 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: mani@kernel.org, vkoul@kernel.org, Frank.Li@kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dmaengine: dw-edma: Add interrupt-emulation hooks
Message-ID: <aZNIIjlEYVbWpIn5@lizhi-Precision-Tower-5810>
References: <20260215152216.3393561-1-den@valinux.co.jp>
 <20260215152216.3393561-2-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260215152216.3393561-2-den@valinux.co.jp>
X-ClientProxiedBy: PH7PR17CA0051.namprd17.prod.outlook.com
 (2603:10b6:510:325::14) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM0PR04MB7011:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a845ead-2a01-435c-0a26-08de6d79e5f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|376014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OX/e+7j6XmdQR5b7LdQPpfmPY7JYLOB6U+T75w8SKjEzufkSxyuN3wrpwleJ?=
 =?us-ascii?Q?JwxHcWKoETpe93FW8irFgMSFdnE7PEKrZ+FSfK1I1GfcecLpCav/2spXpnGp?=
 =?us-ascii?Q?blqQzmpKCf5cYKiaXIplfZVkUUm7i13yaRGn7QS4Bt2jSKXMlOpW2R94QFR4?=
 =?us-ascii?Q?W2w9MyfwLs1Ur6v57iKlrPjyYf5aHM3h1C5zCfQeopeSL4lZpLcOB2X/345w?=
 =?us-ascii?Q?cWlPqcxplXK78ihXgDsWWX7RtYLXE2R1p778RZrBJiI9/d/VVrrsZ+Sh/cJJ?=
 =?us-ascii?Q?UXyg+Lgp6lxvwCJGGrAqefqSH8oJ82xHm48mVtsAu9ip5NAHIjK7ruABuPeb?=
 =?us-ascii?Q?jVx/B5/Q4wntV2HBE4xggBM+rfe97RiS5ykHnkRz1kgoHH5j3NLU50b+IABv?=
 =?us-ascii?Q?ZAGbloOHiEUnh1oaOeBANyRrISrRqrO2jPLEen3TXlPN4IhgtHHDMM3F9z0E?=
 =?us-ascii?Q?+3AiuMuV7fkovfiVLUUUzcvAgLHz3eAlojSxwnl73Fvuk//rOr9/4BEaVwQm?=
 =?us-ascii?Q?uYeLv4nm1ZHyOARHPc3on7B/2Ujf03FNzDnu6fFdiD6iqtkOE2YrOb771saX?=
 =?us-ascii?Q?QauoQ7N5JhV+N2J5MBVmOs9gE5j6QNHYJJGN7zBYV5MhoZ+Ol8eAdEvHnxGW?=
 =?us-ascii?Q?CXM/MiDGRM40ZOWfuN3YZId+4bPnp0aY4nCPra7uvPPUmYK/7BRTXX6JyZwE?=
 =?us-ascii?Q?hqIWkv38DqZpFqzJrSuuETbDbWzXD1kSd7i2P5CWcJSU2QVqhlbH1weNIRWY?=
 =?us-ascii?Q?w2lIOi1c+GDSLRzdeL4keoIZka1AO3Jt7mrlBi4y/RdolQat+wNhpoSqCqPc?=
 =?us-ascii?Q?vYbuFVAEXJaApspPKNRzHIReTZ1oEzOkG9idbw2Jex7eiYvnRbD3ZwmMqxGO?=
 =?us-ascii?Q?NuZty47dDfecw+WP6nTB3eZmt6GBOAgwbQyNOBOGsglo7dDimALEI73G2O2s?=
 =?us-ascii?Q?5uWFK6QMNCqmBQdMLhkIeUbobDwMAWYZyoJVvhbJwxhdZj+XqcMudWdNumgX?=
 =?us-ascii?Q?QM0+gW31JJ7zuTroarfq6jri+rSLRX/iYixtWVK3g6baNmKs9so6PhZrMX5g?=
 =?us-ascii?Q?X6vn3jcfJEGdBEzVXPDzyRYBrhv0KRiz9r/kZ6Rf3cTtNu1/ywmuz4IYUboZ?=
 =?us-ascii?Q?JjahkkESDZLv8j14yIvgZvQqVxAsYT7E/PBCedqF23HSOJbyQ1hcdMHrhAT/?=
 =?us-ascii?Q?uXfCm2odqrXt7H7Y6udDlw/kVaRmeUkEgExxdaO89mNTOfnS3nNDnZgw1PA8?=
 =?us-ascii?Q?whSNY9QFZOFQXT+ReJ77bPqF8YKrsJNG78cJYgpCK8BT4jMnuellz83eAsPO?=
 =?us-ascii?Q?d4JHd0oqqP9mKLP7SEFPs+1c6nfQKyzyLAPfEtu72H9juFxYK8L4MrzE4dcx?=
 =?us-ascii?Q?Np4vqkbbxTFc5qTXTDefnvTDIQ+zCk02RCOMt+DjavpQnOKy+LRBpwBq6c0B?=
 =?us-ascii?Q?Z7DXSo2Z9nD2Amij7grEqAknxnC6924O+mNGNpWT3SAidXynoEaiyVTEm/3n?=
 =?us-ascii?Q?AMbxAzLR4rvyjIkbVbv2mXsOB7e6Wj78K2jhHADhaGQ/liFqFK0qv3ttbf5b?=
 =?us-ascii?Q?aHxHJKx3wEAYijpcal9uRG2UFo4y0GL8JwB+lULWjn9LO4DUWYhBJZsXasMh?=
 =?us-ascii?Q?YoqU7LyaucMWSIXLCvcFn7s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6jI6ow5cIss1hwzvPa0N6bmUVPaJ//SKsofIV5Xtg2fLmWX09YPxxPlcxk1N?=
 =?us-ascii?Q?0H7KatN4kEKfpji8yzFRWi4w8SJNWniPdkTXewc00zuCPGmvPDVgRNgdNhzD?=
 =?us-ascii?Q?IVS53jlZ6nZnLeFtIm6atUUrANU2MXz6YnSzJYgGc4W0NWzCQJab8biQy8d2?=
 =?us-ascii?Q?FbaXbf4G8s5VsWc/sB9hGHAQODUp381oxjWJH9ZvhdoKwVMjk8DFTI42TowH?=
 =?us-ascii?Q?D/aDtUSajiLFS6J+HdeqOJS4Q4Y4MrEmTXN2gG9xircURo5WArE6EJZN7bA2?=
 =?us-ascii?Q?ztETEJE5skes17AlDuATFU96WZX6+rMNOr0GBI5fcLQUkysXmc/KnS7epa8D?=
 =?us-ascii?Q?VTDQtGxmdpmW5G2Ghaf1h4EADqgMx2rfX1ssjypZyOAQAPoyC2aU12Zz9oA0?=
 =?us-ascii?Q?4pkdmeYvdxX0t1JOtXSEbXVUP2Q9KvnCTKHAckBlU8YniIZMX/7GfTSkxYrY?=
 =?us-ascii?Q?ECLFClfOci46acJhR0+rU8GpUJrhXZi0BV9/Uct0iK8vv1uGllCxcFX5vThN?=
 =?us-ascii?Q?gMad3AGLAZ6z5vpJDUR2n+w7IMUfyiin4Jd8OsxOSzJcdUC0eA7IXjX2YplZ?=
 =?us-ascii?Q?5ATJZNwd8oYX6DAapz4I8T9rOqxiQmO7+3/ton9Llmd9KgvLXYNwgtkKoVqq?=
 =?us-ascii?Q?lhr35T/ghODUXmXAJAmpuBqfMt3D9NWvqHb9q4tmFPWzEtUeVIQk/SZnwtAZ?=
 =?us-ascii?Q?sCmp5++LRLoFI4MN9YgBkM68nJ6phXXRXgPnSr7kfX4inrKLMGNa/kD5Q9Gy?=
 =?us-ascii?Q?R0nUVDPlTAqDvB74TWf0LfY+hkOF7vmW+A/ruqE07/2V6ovvuzliv3IjwIYz?=
 =?us-ascii?Q?GMr+/Teypx5qpIiEHY22A3iaL9+0u6Cdv6qMufXL/0ctJFhTQzvH/n3FA6Zv?=
 =?us-ascii?Q?r00fZT1ndlbR0wUbTPMhDEZ08SLUX1dS7WRQe5/JdgskRq3gyfTxpdkN/znA?=
 =?us-ascii?Q?LnXFuaJ1BjSuAwt2WRhhjtc5H+eDRToUQccYwTPVO/VoNgM2YFM3APCnF1VG?=
 =?us-ascii?Q?vs2mPjhq+l1rDGpU79H63ggBcFSVjU8dJUfF+514+L8ojF2ZA7j//qA6pgCC?=
 =?us-ascii?Q?r8xuBxhyRRP7ozz2BSHpgtSuEyEcWp5GC+SkEJbB3icpBQbvBdyAfE6UqC2q?=
 =?us-ascii?Q?jQFnWz+3utignAA7to/zijQIWk/pChvJeKzWBR0Q/bXl5WwQAxANY5B4Q3ml?=
 =?us-ascii?Q?MTLM0JFsNJ2VetTVWykP6B5ZNajSgwU0k+2JpXzw0t356jytkRhhKi4G9cJW?=
 =?us-ascii?Q?1UTYBavmanzkSVQQOGO4twFw2B/sSHNW3ahlQCvMU1eYJa1ISs2aoVU5H54b?=
 =?us-ascii?Q?r47OkjutiLrAHfX4F7vAmkHvTmyupKLYmGMncGkWoO5612ZepneEIyz0Ccqx?=
 =?us-ascii?Q?/yKGjZ9KPAMxbjsoH/QB9AJ+irEMeodDYfTmwwhZHBRlAweOKLxBLFmaNqr2?=
 =?us-ascii?Q?3XcrK6JgVPHtbdTyQcSfnnhI9b62GkhdZV05FpZ2lWJh5gQCyioUEpq8DBoW?=
 =?us-ascii?Q?2EgwuExlybEfpqBP1xISTDhZ+MWq7VG1dOVLQ1aWVjcTsJtChF/jvmdipbuD?=
 =?us-ascii?Q?0QRnDB9huc8Bnd/9vrWkOsBevu7sJ1nWATclH5gcrw4QoqGhEjrJA/RwbcQU?=
 =?us-ascii?Q?wTrFAIDzH1bsomwuq6ejy04lssU/QRh64WE/qVHHUBfkItySLFFLcklYh/v0?=
 =?us-ascii?Q?kC2W3j1EjFqCFEJPWUBeIdPLW8TdMKDjbXfJYQLCcpplwfxa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a845ead-2a01-435c-0a26-08de6d79e5f6
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 16:39:05.2115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q1hbO2LSypRNiX3RVbF2uDGa8xD4elEZBi8TRf93BJTUnccQqm7MPeA+XVVvxO+BKBqpTNvjb6SRJS48rz/RpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7011
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8912-lists,dmaengine=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,valinux.co.jp:email]
X-Rspamd-Queue-Id: 739501464A9
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 12:22:15AM +0900, Koichiro Den wrote:
> DesignWare eDMA instances support "interrupt emulation", where a
> software write can assert the IRQ line without setting the normal
> DONE/ABORT status bits.
>
> Introduce core callbacks needed to support this feature:
>
>   - .ack_emulated_irq(): core-specific sequence to deassert an emulated
>     IRQ
>   - .db_offset(): offset from the DMA register base that is suitable as a
>     host-writable doorbell target for interrupt emulation
>
> Implement both hooks for the v0 register map. For dw-hdma-v0, provide a
> stub .db_offset() returning ~0 until the correct offset is known.
>
> The next patch wires these hooks into the dw-edma IRQ path and exports
> the doorbell resources to platform users.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  drivers/dma/dw-edma/dw-edma-core.h    | 17 +++++++++++++++++
>  drivers/dma/dw-edma/dw-edma-v0-core.c | 21 +++++++++++++++++++++
>  drivers/dma/dw-edma/dw-hdma-v0-core.c |  7 +++++++
>  3 files changed, 45 insertions(+)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> index 71894b9e0b15..59b24973fa7d 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.h
> +++ b/drivers/dma/dw-edma/dw-edma-core.h
> @@ -126,6 +126,8 @@ struct dw_edma_core_ops {
>  	void (*start)(struct dw_edma_chunk *chunk, bool first);
>  	void (*ch_config)(struct dw_edma_chan *chan);
>  	void (*debugfs_on)(struct dw_edma *dw);
> +	void (*ack_emulated_irq)(struct dw_edma *dw);
> +	resource_size_t (*db_offset)(struct dw_edma *dw);
>  };
>
>  struct dw_edma_sg {
> @@ -206,4 +208,19 @@ void dw_edma_core_debugfs_on(struct dw_edma *dw)
>  	dw->core->debugfs_on(dw);
>  }
>
> +static inline int dw_edma_core_ack_emulated_irq(struct dw_edma *dw)
> +{
> +	if (!dw->core->ack_emulated_irq)
> +		return -EOPNOTSUPP;
> +
> +	dw->core->ack_emulated_irq(dw);
> +	return 0;
> +}
> +
> +static inline resource_size_t
> +dw_edma_core_db_offset(struct dw_edma *dw)
> +{
> +	return dw->core->db_offset(dw);
> +}
> +
>  #endif /* _DW_EDMA_CORE_H */
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> index b75fdaffad9a..69e8279adec8 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> @@ -509,6 +509,25 @@ static void dw_edma_v0_core_debugfs_on(struct dw_edma *dw)
>  	dw_edma_v0_debugfs_on(dw);
>  }
>
> +static void dw_edma_v0_core_ack_emulated_irq(struct dw_edma *dw)
> +{
> +	/*
> +	 * Interrupt emulation may assert the IRQ without setting
> +	 * DONE/ABORT status bits. A zero write to INT_CLEAR deasserts the
> +	 * emulated IRQ, while being a no-op for real interrupts.
> +	 */
> +	SET_BOTH_32(dw, int_clear, 0);
> +}
> +
> +static resource_size_t dw_edma_v0_core_db_offset(struct dw_edma *dw)
> +{
> +	/*
> +	 * rd_int_status is chosen arbitrarily, but wr_int_status would be
> +	 * equally suitable.
> +	 */
> +	return offsetof(struct dw_edma_v0_regs, rd_int_status);
> +}
> +
>  static const struct dw_edma_core_ops dw_edma_v0_core = {
>  	.off = dw_edma_v0_core_off,
>  	.ch_count = dw_edma_v0_core_ch_count,
> @@ -517,6 +536,8 @@ static const struct dw_edma_core_ops dw_edma_v0_core = {
>  	.start = dw_edma_v0_core_start,
>  	.ch_config = dw_edma_v0_core_ch_config,
>  	.debugfs_on = dw_edma_v0_core_debugfs_on,
> +	.ack_emulated_irq = dw_edma_v0_core_ack_emulated_irq,
> +	.db_offset = dw_edma_v0_core_db_offset,
>  };
>
>  void dw_edma_v0_core_register(struct dw_edma *dw)
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index e3f8db4fe909..1ae8e44f0a67 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -283,6 +283,12 @@ static void dw_hdma_v0_core_debugfs_on(struct dw_edma *dw)
>  	dw_hdma_v0_debugfs_on(dw);
>  }
>
> +static resource_size_t dw_hdma_v0_core_db_offset(struct dw_edma *dw)
> +{
> +	/* Implement once the correct offset is known. */
> +	return ~0;
> +}
> +
>  static const struct dw_edma_core_ops dw_hdma_v0_core = {
>  	.off = dw_hdma_v0_core_off,
>  	.ch_count = dw_hdma_v0_core_ch_count,
> @@ -291,6 +297,7 @@ static const struct dw_edma_core_ops dw_hdma_v0_core = {
>  	.start = dw_hdma_v0_core_start,
>  	.ch_config = dw_hdma_v0_core_ch_config,
>  	.debugfs_on = dw_hdma_v0_core_debugfs_on,
> +	.db_offset = dw_hdma_v0_core_db_offset,
>  };
>
>  void dw_hdma_v0_core_register(struct dw_edma *dw)
> --
> 2.51.0
>

