Return-Path: <dmaengine+bounces-7583-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE5ECB7CDD
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 04:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CAFB43005AB7
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 03:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BFF28AAEE;
	Fri, 12 Dec 2025 03:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="cPCthAVM"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011027.outbound.protection.outlook.com [52.101.125.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5167D29D28B;
	Fri, 12 Dec 2025 03:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765511824; cv=fail; b=B7R4jkITZezglfGgfXfeneXRHFhJFig9JyZ70WwhC39/KNxpGsBy/v2lW+pPjWVnsU3YyYbyeoRn/GB1XTiWJ2ehNE3Qsp14yNc0ZyNNFDPuK0bd+qpyjzY71Rfk+aKPhbxKG1LJiDSgkAZdodMtpDlAqsr92tg+8IUmOiGXjMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765511824; c=relaxed/simple;
	bh=7EktyW7Mzv4ASm//1tRJzc72ZakImdiyOxQ36EYn52A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B7eCKRSklZHDWDTf7h8uNZDUk3dmNDphquETL5Z19ZEP/BKbqn3wtCnfDtRsKaMh19ABqTcxQDtgKf8ausOL6hPtrpANfuIUovixohTRSDteYX+HUPRooLyDv5ercY19Tjx3XY7l+jr3pMTwN1hdQRga89gZ5ST7cDoo4v5GdIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=cPCthAVM; arc=fail smtp.client-ip=52.101.125.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DpeL4lkn1e3S+x/I3ky7ybV0obxUe9stFWMMMBiUlnvhd8PyQG6bdBzJ2CJzdEHlaqOZbXdVnjPqARlkoyP0SNpDMwx9A1xDq9+4eKu4uRoV7b2o13Qan9QEXdosaH8SUt6jcRibahUJdFZ5gU5Y8EjkY6xLC5hpeeudIFNx4DImq03AUltDrhPd1ZXhjzaUYgiSbjU3HiN9nfg+YCFY21DHROAJrhWu/OXBmLPTq9xMBY/Bo+JSrmsKipTdzp7zprXssQG24TLsfeYwFR/giTBra4iTbLTCZ+xt0e+ZhwhGMjrPKTHLodyVka/IpWOESIwNNq8SIciBt7PNMvI90g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1NTDvrgLeX+Mpp9Empu2uAsK26OKje6i6wc3JbnOSd4=;
 b=VR9OqA6UKEulCAx+jflX+UHSEdo7BT5BvDtpZv5yl6YaBKauuYmlnda1Vjdm9zmwFCelNaEJ+rm8iEqTLZCAmVUFOfSJxU4Ekmqz7K1LcPuR6iqCmKWqUh9W1jcOnxLk/2VjJ0AwCWWgrtRrtWWx2gK7b9sDh7iaEDbgFRzszP4jeDb6BJYQRG026Uo+Nbaiv67zLKXcpP3zNDjx6ElF8RWWrTTkdyOGzC4d2ImY4BXY9sEfvE7Jq/DCI3lRvVQoEZ96tZZPBXFot4YScBrfH3GtvSu670STFJbDgvHhKFZZwUDIw6ndtAXXkYYDWQTDHvrCqeFzZjFxyM7YwFCi+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NTDvrgLeX+Mpp9Empu2uAsK26OKje6i6wc3JbnOSd4=;
 b=cPCthAVMHKAtHdNxrYbl4Wjd49ig8fP2S4/eTXRLiZskOYHM9z7z5XDxhxbe5bqAjoktU+gnMRR2Ez0Wh2N3TbfEmqyq2+cLoaTJscxFWrbuWLZMNK+UgPUKNXqRvLpvmZzWijlaArCzcNVZ2g6+q55ZnPoxzZpT9G8v5zMmGVc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TYWP286MB2155.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:174::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Fri, 12 Dec
 2025 03:56:58 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 03:56:58 +0000
Date: Fri, 12 Dec 2025 12:56:57 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, Frank.Li@nxp.com, mani@kernel.org, 
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com, corbet@lwn.net, 
	vkoul@kernel.org, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, 
	Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com, kurt.schwemmer@microsemi.com, 
	logang@deltatee.com, jingoohan1@gmail.com, lpieralisi@kernel.org, robh@kernel.org, 
	jbrunet@baylibre.com, fancer.lancer@gmail.com, arnd@arndb.de, pstanner@redhat.com, 
	elfring@users.sourceforge.net
Subject: Re: [RFC PATCH v2 19/27] PCI: dwc: ep: Cache MSI outbound iATU
 mapping
Message-ID: <il25wipcfl5jvafmfpzan4o3oesivvlyyxqwaayh6duxzudizt@gvqiim3kjyng>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-20-den@valinux.co.jp>
 <aTaE3yB7tQ-Homju@ryzen>
 <aTfavdjoc2ob2j2g@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTfavdjoc2ob2j2g@ryzen>
X-ClientProxiedBy: TY4P286CA0056.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36e::8) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TYWP286MB2155:EE_
X-MS-Office365-Filtering-Correlation-Id: ceb79288-690b-4aec-cb0d-08de39327f95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rC3m7qRxgAh3+9RfgP2xaHgTmZXTYwZYkzKVXOg02bWyAL97bJolKf8xmhSy?=
 =?us-ascii?Q?ZjTVShYa1wEcty4s236Xv9/zGuMpbob7UNeNZPQ61afsO7Ybl27XWsbS3oct?=
 =?us-ascii?Q?CCuf0HkSlONXKU6OfO7hyy+olcBiSrIl1A6zIcDJF+6FVWfo1p9AS9Vhh7zG?=
 =?us-ascii?Q?0PHmEP90WtUHr8ssh7wqjMR8mkBcb3o2TmSuxZMybg2yQvWSb7uuHMt4tALc?=
 =?us-ascii?Q?bPPPu5H5ld4ehuiIevmpzRwvFSU8udO2YxW5wRUMz7NLQIV77Lxyphl84RIm?=
 =?us-ascii?Q?ParVpVitMabuQ+/UkLdLuJ96JsA/AWDZHGPw0btev0uywSrkBpG+BMxFtLOO?=
 =?us-ascii?Q?vd60qp4tmDm4p7lXwu1AaQeSImdl/wJHb5HE4pt0uEJai1XIULfh/UWUvFl+?=
 =?us-ascii?Q?+KG4iuk3CdlK63/AItPTsZd9kL6QGrZwCJ8MEtsqdhJwRimB9S3m+lHs2UNW?=
 =?us-ascii?Q?qbgm+Sdk4KofsVfzFfHwBai/5U/PPNNLJr2A1YbUmziW8qb6TC6l12U/BVRg?=
 =?us-ascii?Q?kpAvdcDd3/eeY4u7EcdRF0sIEDqXkCv3O3/Elz2b8vi1GsGMhsR2GC2dEdmT?=
 =?us-ascii?Q?FNEAiAnuGNLGZEK0kTzuEDgfSTyDe6tQ7+0gT2ZHu/CX8EX86pR7rONTQfKq?=
 =?us-ascii?Q?kM3cZ8mwfehH1wCABU9Jj0x7dynt1tlwP+orfqtc+bgjHUd5253jjRr6uVaf?=
 =?us-ascii?Q?DiYKXNWWAKo5tmbLBQGiMdH7Zso1o+c1ojieMoVXnhzdZYD2vzs7DQnXwXZt?=
 =?us-ascii?Q?y7OWP9fVpI26p+iq6fsOrmAQLyVJS/aQ7+D69j/gGJwxt16Dkd09iGlp0RCM?=
 =?us-ascii?Q?+uYLDjqHH+I2oB3V2XK5ZrE83F8bRbiZw9b/HzboEWsWJMeqR5/YMtRYMuKb?=
 =?us-ascii?Q?9VjdimVACKCKMvhl+HyJIlpZ+b1vUqRC/dW7VJIedeq4Jl0F6muh8Flia67f?=
 =?us-ascii?Q?aLQpG/pbFlc3x/eBokODKG+PpX5uNyOur47YpxRuo7xzSsOzNIw+8YplwHtY?=
 =?us-ascii?Q?l9tInlbEvKdP/zE1JUS0xwOahBPCq31S5kSObudDz3BoEO/moOdX4/QkB8FH?=
 =?us-ascii?Q?2VWry6WW+7Z/z4cdxxoJnDbs+RahvYF8WIp6JoVhuqodBd/kxuHc+W2RQT0J?=
 =?us-ascii?Q?1wZtum3//Wfb23RVSHBaKMZ8vJxSKxxA8p4+Ryi9N4ypoTRcNrXgMZ7rmrV5?=
 =?us-ascii?Q?hSa93JFQ+lDId+phM57VeodvXSa30WsCaodlaiD84WzCW7Va7yibQTUKCNeH?=
 =?us-ascii?Q?HUXbjosHmfk6HVYqu75L3hRJfKAGwobFzKG6uIOJtcd55MQ1sGsnAE3jWTX6?=
 =?us-ascii?Q?lR6qdaDhNhfhocVJVRR7O/eMiHckTDY76wUOo9oaol6duxmk2K1Wj3lYzs3Y?=
 =?us-ascii?Q?7u4MtoikUwguAqCTezzM2u54DBcEM7447Nq7CYvQLxEc0S1CeMYh6E1P4DxT?=
 =?us-ascii?Q?WA3lUTTusH3aOshv3GbHTcGCxd6RPvGbzTh31Ab3Bud9SiXBMhhIRA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VVaQVZn6te8EBJfZRPZEgVyvEh/oCxsQ7dIPYd4I/XyZnwRPaLtLfGDzOFRU?=
 =?us-ascii?Q?U+Bzp7meOQ83caDY9atSBSueK7khjkyV2Gu8PoXvsWfu9AQLI6/gO7TItFxb?=
 =?us-ascii?Q?eEoL+325iisgtlDc0h8gJIE26xrrHUufdiYz2vWuXh76DvWD6VZ1YdaoXHbH?=
 =?us-ascii?Q?LcAjYK3Gb6tcsQHgyOkK5NU+33UNfOzb9UqMe23rSkehV7JmF5T04KY0bBgb?=
 =?us-ascii?Q?FmhsOm07hanL52VA6KMyq6DugtMlODJSqCH+DnUAyQqhiLR63eZj8XQ0nl1z?=
 =?us-ascii?Q?xwZ78bVHWiWiGljs2N/PxahrfnTI8+dxMCFk0hq5QlswoAeYEWaVr+4OVKNO?=
 =?us-ascii?Q?eACxGIT241FDD0cKfMu075RPbIa/TVCHCfIDz21J5XJpcZe9lRTps39Uaspj?=
 =?us-ascii?Q?VPAkDodkXz7foRIU1sjfzfSWZCnBXr3HbrdnSkPZCc8bMWkMg6KG2NObltMO?=
 =?us-ascii?Q?5yDp7prUZMCrVC/+MlnlhWDMBX8RQ1aAXOgwMdgmqUwVJexIq8RNljzsWfH/?=
 =?us-ascii?Q?8oy03oV4MeDS0ZsWTfqGIrXt5Hk5v3vxiZ/4ZAS4sqO7wQcwjVej+N0QR4cE?=
 =?us-ascii?Q?3H56WIlaO/E7ZMzyG1v04Se0ayf0CrGjlVkqExca3At3iClBh78Vfrs0y51O?=
 =?us-ascii?Q?/XmyqBKbqYUruicbM+GBwAllygGEGTkbx+Ot3lf69btctU0K3XHxif6E/Uwy?=
 =?us-ascii?Q?zikGsDbuYjXe9jsAttZdvYCDA4GPildGxG1ApgIZk3K8H8d+cz8oRBvB7muw?=
 =?us-ascii?Q?eDzEAODb6LST6OykPZHcumtp5WaqVUuzaN+KMPXwK3OWWjArccZB+LjV1P9v?=
 =?us-ascii?Q?kHlePulQ4G2hH/OOT1RuRjwDR5SviM8WsVOUFOQRVxmqnTgWMcxNNGpb/BKu?=
 =?us-ascii?Q?AaQCmzgv30REPYMgkAbNFCJpQFCBZMXXsvUba1BV36dyVBEc7jdgS1vPU85l?=
 =?us-ascii?Q?Sq3kPIqrnJpDF6gwKNbFS6KKWmCexZJwijur5MevwEmqnnlaGS/MDrsoVHF4?=
 =?us-ascii?Q?7ix4fuGTZbnAcJBfnFlq4KXZ8GGSKDzwVxYDZYqLQDdbN1LpIfv6EGEwqtVD?=
 =?us-ascii?Q?jltwnL5e962yMbgkTcdTPTPXDekKk+UGdcP9ArULkXF0PPzDpk4qEt5VnITe?=
 =?us-ascii?Q?N7v+K5GE5dOKyFbZjfxiFojW1MH8uo/lyNycgdRL59RjgjAHwiIPZ8gx6HJJ?=
 =?us-ascii?Q?pbSOBHEIZXJShhU0aaJAjMCaHD5tcoNoq43lcMbv7dnHQjcBMbA7qH+xfgXA?=
 =?us-ascii?Q?0WcRaf7XXZP+M4OwV2wJAZbg8RvVKSBb3ME1SNUGBXo6YFYzqB2WWNYowmDz?=
 =?us-ascii?Q?ApXEfKGOsf6V9PlwRS8tt6kYYu6peu7PCWMclUwvAGGawbmdpdwYtGarQwWQ?=
 =?us-ascii?Q?f2HZkMD+3eun3KfS91i+d/wESCLTD1N+DMQjT+x3k8WfJHhBATOrW6+hsEC5?=
 =?us-ascii?Q?2PW+UTkfKDMqmZhL1FDvY6yJyY6xh3+NEpM6+oLPsOjgHtBWtDpg1X+Pd0Cd?=
 =?us-ascii?Q?cbFjeWFp+bVQV7REoHn4a86djAYoP4rHbeMM+rSGqb91ye0FFvDG1yiEKR2O?=
 =?us-ascii?Q?3Pd0YXlDko4+lAZ1Ufxdvd00Q5Vw7Tnc2nVI4xMWioB2w88LAnDx4FqRDzb/?=
 =?us-ascii?Q?DMnuadDbhGh41AQGW47VMV8=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ceb79288-690b-4aec-cb0d-08de39327f95
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 03:56:58.6175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YGEJu8l4QKNZzF93tnNbp6vjViMPMjASNfB0OxmF4l5b/qicCqI/hfbYnttmK8DnKQdrOWoDm8zfHp+HrAehxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2155

On Tue, Dec 09, 2025 at 09:15:57AM +0100, Niklas Cassel wrote:
> On Mon, Dec 08, 2025 at 08:57:19AM +0100, Niklas Cassel wrote:
> > On Sun, Nov 30, 2025 at 01:03:57AM +0900, Koichiro Den wrote:
> >
> > I don't like that this patch modifies dw_pcie_ep_raise_msi_irq() but does
> > not modify dw_pcie_ep_raise_msix_irq()
> >
> > both functions call dw_pcie_ep_map_addr() before doing the writel(),
> > so I think they should be treated the same.
> 
> Btw, when using nvmet-pci-epf:
> drivers/nvme/target/pci-epf.c
> 
> With queue depth == 32, I get:
> [  106.585811] arm-smmu-v3 fc900000.iommu: event 0x10 received:
> [  106.586349] arm-smmu-v3 fc900000.iommu:      0x0000010000000010
> [  106.586846] arm-smmu-v3 fc900000.iommu:      0x0000020000000000
> [  106.587341] arm-smmu-v3 fc900000.iommu:      0x000000090000f040
> [  106.587841] arm-smmu-v3 fc900000.iommu:      0x0000000000000000
> [  106.588335] arm-smmu-v3 fc900000.iommu: event: F_TRANSLATION client: 0000:01:00.0 sid: 0x100 ssid: 0x0 iova: 0x90000f040 ipa: 0x0
> [  106.589383] arm-smmu-v3 fc900000.iommu: unpriv data write s1 "Input address caused fault" stag: 0x0
> 
> (If I only run with queue depth == 1, I cannot trigger this IOMMU error.)
> 
> 
> So, I really think that this patch is important, as it solves a real
> problem also for the nvmet-pci-epf driver.
> 
> 
> With this patch applied, I cannot trigger the IOMMU error,
> so I really think that you should send this a a stand alone patch.
> 
> 
> I still think that we need to modify dw_pcie_ep_raise_msix_irq() in a similar
> way.

Sorry about my late response, and thank you for handling this:
https://lore.kernel.org/all/20251210071358.2267494-2-cassel@kernel.org/

Koichiro

> 
> 
> Perhaps instead of:
> 
> 
> 	if (!ep->msi_iatu_mapped) {
> 		ret = dw_pcie_ep_map_addr(epc, func_no, 0,
> 					  ep->msi_mem_phys, msg_addr,
> 					  map_size);
> 		if (ret)
> 			return ret;
> 
> 		ep->msi_iatu_mapped = true;
> 		ep->msi_msg_addr = msg_addr;
> 		ep->msi_map_size = map_size;
> 	} else if (WARN_ON_ONCE(ep->msi_msg_addr != msg_addr ||
> 				ep->msi_map_size != map_size)) {
> 		/*
> 		 * The host changed the MSI target address or the required
> 		 * mapping size. Reprogramming the iATU at runtime is unsafe
> 		 * on this controller, so bail out instead of trying to update
> 		 * the existing region.
> 		 */
> 		return -EINVAL;
> 	}
> 
> 	writel(msg_data | (interrupt_num - 1), ep->msi_mem + offset);
> 
> 
> 
> We could modify both dw_pcie_ep_raise_msix_irq and dw_pcie_ep_raise_msi_irq
> to do something like:
> 
> 
> 
> 	if (!ep->msi_iatu_mapped) {
> 		ret = dw_pcie_ep_map_addr(epc, func_no, 0,
> 					  ep->msi_mem_phys, msg_addr,
> 					  map_size);
> 		if (ret)
> 			return ret;
> 
> 		ep->msi_iatu_mapped = true;
> 		ep->msi_msg_addr = msg_addr;
> 		ep->msi_map_size = map_size;
> 	} else if (WARN_ON_ONCE(ep->msi_msg_addr != msg_addr ||
> 				ep->msi_map_size != map_size)) {
> 		/*
> 		 * Host driver might have changed from MSI to MSI-X
> 		 * or the other way around.
> 		 */
> 		 dw_pcie_ep_unmap_addr(epc, 0, 0, ep->msi_mem_phys);
> 		 ret = dw_pcie_ep_map_addr(epc, func_no, 0,
> 		 			   ep->msi_mem_phys, msg_addr,
> 					   map_size);
> 		if (ret)
> 			return ret;
> 	}
> 
> 	writel(msg_data | (interrupt_num - 1), ep->msi_mem + offset);
> 
> 
> 
> I think that should work without needing to introuce any
> .start_engine() / .stop_engine() APIs.
> 
> 
> 
> Kind regards,
> Niklas

