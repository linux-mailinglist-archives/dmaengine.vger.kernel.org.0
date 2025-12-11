Return-Path: <dmaengine+bounces-7564-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F46BCB4AEF
	for <lists+dmaengine@lfdr.de>; Thu, 11 Dec 2025 05:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1FAD630014D5
	for <lists+dmaengine@lfdr.de>; Thu, 11 Dec 2025 04:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22E4238171;
	Thu, 11 Dec 2025 04:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="wlAm/0wE"
X-Original-To: dmaengine@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011043.outbound.protection.outlook.com [40.93.194.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D23279F2;
	Thu, 11 Dec 2025 04:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765428050; cv=fail; b=giHFTejIMaPvSxf+1xqeHj2HrX5h4MSRj5M6G/k6q5keQhzpyzsBEFSuGSoJWXK8P7oma4TRu195UICvtWjjd7C0Aczhbm14Lin96hBm2T7vthwTwAqHuJo6auHgGtr2N3mOSOorzfU7pIsoFDAhGfuX7nrIthAOoPIdaXkmA9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765428050; c=relaxed/simple;
	bh=ycCXp34XHM1Ar6Uk8zDzRIBDJ/PSu7QSupO37hAuwQQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=iYusbvr1gORw4AHTqST2q1ZleV1x1bZfj6HF72NN2gzF0i3Y+gtc43yNXCSU9sjLqPUSAkJV8VVwBzANDcHKtMtpdy97h61+bRJ462WptXuVyyddK9JZShe2B45RyWLyDTZRb3Gf1Zegynd3VjHtwh6G796Y0WA2v20RMiyPn00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=wlAm/0wE; arc=fail smtp.client-ip=40.93.194.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVX116Bs3+wWhnnc9aMGZOn8AgjIibYo05MzbWpn+chOIW47EDn7sZlacNYc8UoRd5Z+qSKEkz4r3XF7XD2h91i0caniHMe3rWbcYkNZgkNDKA42CtDX6trxEoxyQ0ARvbuwGntyUl1KH9BpgBzbs3TfCRLFum046+Ypho5RDpm5knVDkfH6EIpCgiXWJv95L0wdqwki45+mr+Tnov11u0Z/jctIG3oYmwlxBKaHCZcOWs+4kuE9lzFovG6cd30Y9DSc+IfDuLxKZzYwZbHmwaySPDwXj1Y9d2rP+KYSt+XVfJjpOl3N4HEWw5cOvqmE/1n4jmf9L36XZT2j+yi2NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpaoaKiXcCfUufYqjOrZl+ROCJEsL+xrH+PctaF7alk=;
 b=FpwK8+mWEWIhIZIKfHjL+C/LSLIDgVXqikMYS6yJmkROWVFIwosILdcEs9Z5uevil4d54c6ogvYnx/+/F9OcIkSr4d//89BAFyzxX9dV5m8KYqezss5zLMmg+D/Q1UifPgalGLJclfiCS9eWVt26zjmRULb/3ZFTSD2kYvn/6sTOZxOcn29JvG8oAZFfXnlBfLvGsvLtZxQDj1JDN14PlzIXGbm/UGvvX670cyzdMOFIc+ISxSWu5d8GrevhJUwCv3SUUmgK66g0TZwoOISx0sGhWpb090wPBcN/9cTGR6jV/yKxLZxV3DrBwz6NTr26yWQVa/x6Q124PoHsLpqeSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpaoaKiXcCfUufYqjOrZl+ROCJEsL+xrH+PctaF7alk=;
 b=wlAm/0wERtfUltLA36PBQoHV2NEVCqs4P5WrYO0R60vV6ZAZ1sUsGXhO4jW3KCsSLjkwRv2UavQy/IUykhTytaZDlG29yB6DWAvAg55br3iNLqK95ewmeK5xXqifapUy7aeeZBg2Yj02PpH9LWov/vA3CUm6XNjFrcTP/jrFqoYMrJo3SEPVC+15Dk+a8czEGMqkPShtbE/QW14Pz/f5bD21yNn6OlAjAiPzrLewx0yvt66ALRA1kd0NcM/TL0igEaDUKw/jNvmwQ2wUM+tzAqa/7qve8XGjNmbFkLIVYB4vNajvfOpcQ5DzFyIUzfqelwdws29dR3avEbgCarlaug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS4PR03MB8447.namprd03.prod.outlook.com (2603:10b6:8:322::12)
 by BY1PR03MB7945.namprd03.prod.outlook.com (2603:10b6:a03:5b4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Thu, 11 Dec
 2025 04:40:45 +0000
Received: from DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a]) by DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a%2]) with mapi id 15.20.9388.013; Thu, 11 Dec 2025
 04:40:44 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH v3 0/3] Add Agilex5 AXI DMA support
Date: Thu, 11 Dec 2025 12:40:35 +0800
Message-ID: <cover.1765425415.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0060.namprd17.prod.outlook.com
 (2603:10b6:a03:167::37) To DS4PR03MB8447.namprd03.prod.outlook.com
 (2603:10b6:8:322::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR03MB8447:EE_|BY1PR03MB7945:EE_
X-MS-Office365-Filtering-Correlation-Id: 68b458f2-20aa-4729-a34c-08de386f7240
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R1aMXYO9MrY6cQctXp16Z2AP9Bi1WT9ESd4qLpwgyqwOxw+rL8cdSIajoozQ?=
 =?us-ascii?Q?ZBnljEVUIJTKwNFvJTyvXX5IMDbjZrWccALWZ9s3x95n8oFBUWx3xeaaSAIj?=
 =?us-ascii?Q?imajE98l7ClXt8VYIWoxtquh3Bgdqih084mOls+9cGtnQDaPLVG7qukSJ2C2?=
 =?us-ascii?Q?dhLyavUGbNu9uoOJOqOBjUliR9SxLfzymxhJcUA52t7PoYnUTLGb4Q0IstgE?=
 =?us-ascii?Q?QJt34QWLZ84IB8ir7Ehynt4qdHPqJLhuv/hUMF7mixeUCSWpPly0b6c4u8YS?=
 =?us-ascii?Q?JI8gd1QYvIckMiujIiKN9er/NGUONIlatTOSW2VUtFq+bCNS0bvPJxgoaA2P?=
 =?us-ascii?Q?rSMKvHOciGIX++ajXOMe0wDVSoqGP+TNr0KVBvbGYJ69FmDPqmj89H6S3q92?=
 =?us-ascii?Q?ZSSufv/wIKv9jjl7QKfuFiIfXHVF4wyX6zc62aqD0WF3nqj2OOPmOss2gUND?=
 =?us-ascii?Q?RSoKlPzoYi1OIgAhZnzyDKqsa7sqQxXFFnvf4VbTZh5RHTubESaECY5zXcs3?=
 =?us-ascii?Q?MTPVaWPdntJeDIxyYSmGHVscg4JGAP4wd4c5M+dgsiQnWYcBYd3MvaIAL/Qw?=
 =?us-ascii?Q?EbzmGMsKXoRfG1G+paymPuKtO2XjQDos4KeEwDFVlooIbgc00xw7gkMOYq86?=
 =?us-ascii?Q?ZXAGuNSapxdIGDkJrS4nuEgmHSWJWMoCOmYXK2WVjCxwT/8tLAaanCXEGsiE?=
 =?us-ascii?Q?2YBBDCh723R/9x5Q3nS/UKeKCY5KzK+rsER9bYoWQdi8Cmq3vXMYL/RQzjZX?=
 =?us-ascii?Q?nprX2vFHIxqN8ltPVxZ1+786okqrr7FPj+/Wy78aogM8ApSR21/mRt73c17X?=
 =?us-ascii?Q?CcHgFuEwbDt6IwTV9in+JUA1psdSTu0XbmucBFmvbiCb4SbY2jK+00eKbdys?=
 =?us-ascii?Q?CAAPCJ/XqoYGTq2hWDGiB+9DZFV9Qa0ag+oggif4qVP+sRXgJKEF5H+i9IGy?=
 =?us-ascii?Q?Ev3lPRbxON1NfBKLe01K7J0MKVagNj6eHWzkQeuan2n+zMLdoDFyGkGnQTCS?=
 =?us-ascii?Q?fCDfJq0utR4fefNDeNvL8fLu5dY217z27h2KNGvGFygGKUqlOCOl1qEHPFPV?=
 =?us-ascii?Q?mInGMZRRp50Bk73Ejvl2ZHR+EJ5Cc9qf8iviqU54vAQIaQ4t6ZDX5KuGcPKL?=
 =?us-ascii?Q?6QYDlNq5CpwooZJkT4JHzk3QEqPHy8k0dvh9KcO+arJSZMeloIlHKuBXrErJ?=
 =?us-ascii?Q?JTWU7mcOBMtrrEjT/VS4771QorE7HDt/1J9/1YhEp7S8Rr1POEzLwoza5vUm?=
 =?us-ascii?Q?BjIq/4rPvgo1/hP1dDg/Lq0ypN5BU7/CeoXNKNjbFmw8pRGwUhLJ4Y/jpZDn?=
 =?us-ascii?Q?VdCpn5Ww9F8W81sHit+le3gVd9ij4LyCk6tz4B37NwYdTSCgcgLUCo7tIzbP?=
 =?us-ascii?Q?Apuo9y4ohP51qk+yIxVzbiYBxKrGKOLg8l21HZKUG5DoDZkTVniWaAE/2AhP?=
 =?us-ascii?Q?jUw0DlNHe0tnUszn7zYx6vGZmXj8eIB8340VWz3x+fGQAmWHJWJ0pfn0J2EA?=
 =?us-ascii?Q?2Gw597pc4zPAhV4z3FqHx+6jn9/+WEXX+gzX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR03MB8447.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zfxrsi9OvnXFvnauZHhJ6LwjL3cIaC2vHvaFRMaWRqKkcRQ6nxehMENihpwj?=
 =?us-ascii?Q?JHLyiXwH6YVGX5O58ePyMIDqDEe2r042Q+SAdDccaFTw7IWqpsg34mT0x3HA?=
 =?us-ascii?Q?qfs9fMAOqQ/bFIZLSvAeoXWYGaf+7YHU2xgWgT1zZdNVgeeXzz+U9A8e/2g+?=
 =?us-ascii?Q?c34264jwm60D0QmkatXlQk9B4yawP2Mj1EPBlut+OBxI0xDoakXnik7Hy2/I?=
 =?us-ascii?Q?qpRg/LpxFGxRwhaYbSpdSZWXstPzTqDXSGHoWt6Hx5zPFqvRmpBpM0SUgdnv?=
 =?us-ascii?Q?IJMwIbjrHVIRb+cBgwyqeUDwksdkF7NBup227RsbyfIFsf9dqhbQLqIXbhwo?=
 =?us-ascii?Q?XvZBLOdLW9HLLLwuLv+p0FD4p+jdNNi+nqRiHOVa0MCycPUDYez+vsTPBbbT?=
 =?us-ascii?Q?Lvr94+cc2t0oZCQ9rwGF9vDgeZsOD6mckd3P23wKsm+lVpMQxpAkAUNZWWD7?=
 =?us-ascii?Q?gKOM3mrlrcrgBvALDDgtsC2RkHICVCeDR9epOEagWLrLFkm+KDoinP7IHpT4?=
 =?us-ascii?Q?4seNE7vhtjXV3LWu/Yn5zixsMEwZeP6KgkYbUL/dQydZcPjVGWVhPPuo6Z7l?=
 =?us-ascii?Q?AKvz/kCRHf9OVThBMXQ5B6+xrbR1zX3TinhtbbUlOYPB8EgHp3AebK0eg+lU?=
 =?us-ascii?Q?47I93kL5ePVUWa/xQ8FnKeLEP1Y4Srd9B4JQBCLdRQBAAg8zW2WS73FK+M4+?=
 =?us-ascii?Q?KRqF/Xj96di0LlV/BN89rAr2rsWnAck1QDBW3saCHMDx0mQFZ6Wf2tMZYr/d?=
 =?us-ascii?Q?E3TlAG0NolNWENkvjxQuOH6U2l/R1teidgSC7Rl2/zSjC7OxwWhFCWSmI7i+?=
 =?us-ascii?Q?ffdWq/gSsbKAnNVdV2dMXBu4aper8vNxu5ur7ZNFyshNXPf+WSud+Xt21Arb?=
 =?us-ascii?Q?hUh3tR1zGglMaE2lKyqD7XYWoU31nzCyN7n3kvrNImMLEgiEys9jj/4/K9/R?=
 =?us-ascii?Q?iht8SrYGK0ySTraMwjwQDc/Z876XvUi0CJEUeeAlVj2oL5XR3lrpQr83LmRj?=
 =?us-ascii?Q?s03diIJyQikHQjqi1AThWp7Yrc6iNyqHEMcTL6ZCj29HO43b5MN8RsqdjzVm?=
 =?us-ascii?Q?RHecvegzYqWeeTXh1KaMMB4QU9MynYGeQ7dJypvzf4BLhzXu7/4SCzsrQIE1?=
 =?us-ascii?Q?tZ4fgOuUo/j8JjCdZzPVphN1KXiil0cgwzoN5HSiQ9gmcUo9zcTJteGz4EjB?=
 =?us-ascii?Q?r0YthjIDKtfHPtUxu39h1AXOn+pHzIi/fUf01Xoo9meKkCvc9kqY7HtM82XI?=
 =?us-ascii?Q?1La/RxXzR64l8Cl5lBAGX7vu0sNum4IYk60V11UqcCAp7F1iWQb028GeOkNh?=
 =?us-ascii?Q?7hcjQfkZLwRtbiJ2YQI6odc+kZAkqnmA9PXQup+nf6TPX2PoY7DOMuJRk1PX?=
 =?us-ascii?Q?QwvqpZQ7biBoZJA8+h+jJahEeV78ZpvESXtp15HXbFSKEeqDcDbwVybRmgos?=
 =?us-ascii?Q?2zLzaf1dPdD24P7uedimSGkXa7BE6sj0n6t4HO4NYep66k9HGDXFEk3DEcjn?=
 =?us-ascii?Q?9ML7vHrScSXydp8KrnSeOHmQ7AA653Xcx/nqly3fXVT684xRIHIHXQWT3Z+Q?=
 =?us-ascii?Q?nH2KxwH5iyAf/VcI+ahRLkrl4Rmp3qtjW8IB+xLebDEANIn0vJxvz6v8GtsA?=
 =?us-ascii?Q?mA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68b458f2-20aa-4729-a34c-08de386f7240
X-MS-Exchange-CrossTenant-AuthSource: DS4PR03MB8447.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 04:40:44.5296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XI9IwiHA/6qs/Aj29BLsfoMAyViqAFvdWXwUeX7RQX0Bi08Cvo9tdW6poALQAIMn3CEnMHOu6qGfOVW9B+eD5oo9yMqpcjd8jZyRY+BHdHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7945

This series introduces support for Agilex5 SoC in the Synopsys DesignWare
AXI DMA binding and updates the device tree to use the platform-specific
compatible string.

The Agilex5 only has 40-bit DMA addressable bit instead of 64-bit. Hence,
this specific addition will enable driver to handle this limitation.

---
Notes:
This patch series is applied on socfpga maintainer's tree
https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git/log/?h=socfpga_dts_for_v6.19

Changes in v3:
	- simplify dma-ranges addition without description as per input
	  from Rob.
	- Add simple-bus to with address-cells, size-cells, dma-ranges
	  added under this bus-node.
	- Move dma controller device node under simple-bus node.
	- Rename "arm64: dts: intel: agilex5: Add dma-ranges, address and size
	  cells to dma node" to #2
	- Drop "dt-bindings: dma: snps,dw-axi-dmac: Add #address-cells and
	  #size-cells"
	- Refactor "dma: dw-axi-dmac: Add support for Agilex5 and dynamic bus
	  width" to align with dma controller node now under simple-bus node.

Changes in v2:
	- Add dma-ranges property.
	- Add address-cells and size-cells due to warning when dma-ranges
	  is define without address-cells and size-cells present. Also
	  prevent kernel panic if address-cells and size-cells are not
	  defined.
	- Add driver support to handle defined properties and set the DMA
	  BIT MASK according to value from DT.
	- Rename "arm64: dts: agilex5: Use platform-specific compatible for
          AXI DMA" to "arm64: dts: intel: agilex5: Add dma-ranges and
          address cells to dma node"

This changes is validated on:
	- intel/socfpga_agilex5_socdk.dtb
	- snps,dw-axi-dmac.yaml
	- snps,dw-axi-dmac.yaml intel/socfpga_agilex5_socdk.dtb
	- Agilex5 devkit
---
Khairul Anuar Romli (3):
  dt-bindings: dma: snps,dw-axi-dmac: Add compatible string for Agilex5
  arm64: dts: intel: agilex5: Add simple-bus node on top of dma
    controller node
  dma: dw-axi-dmac: Add support for Agilex5 and dynamic bus width

 .../bindings/dma/snps,dw-axi-dmac.yaml        | 16 ++--
 .../arm64/boot/dts/intel/socfpga_agilex5.dtsi | 78 +++++++++++--------
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 69 +++++++++++++++-
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  1 +
 4 files changed, 124 insertions(+), 40 deletions(-)

-- 
2.43.7


