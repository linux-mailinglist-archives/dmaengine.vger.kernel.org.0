Return-Path: <dmaengine+bounces-7458-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D803C9A537
	for <lists+dmaengine@lfdr.de>; Tue, 02 Dec 2025 07:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BECB1341363
	for <lists+dmaengine@lfdr.de>; Tue,  2 Dec 2025 06:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D942FFDD5;
	Tue,  2 Dec 2025 06:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="La4nfOCJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011046.outbound.protection.outlook.com [40.107.74.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C712FFDED;
	Tue,  2 Dec 2025 06:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764657206; cv=fail; b=fApUe55kbJ44HFplNBkZQbktoBiTc+Mljda6EVamqla1f4ruMwmIH9IGYxWornir1xIL+lI+wB5sJ0tRkOaErOoONyV1rLEXdubCH/91YxjbVnP5FBAaEZJBDN3kIzvT4EI4wj7bn3I717hiZaqy5bGYdUojpG56HkoGtG4HFI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764657206; c=relaxed/simple;
	bh=a4x52FoouLMJ/aK9yz2e0a1dzQj7159PhKCdv0M6YkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tlu5s3gHldXJyNi43y0j4/SNyWYIZ8w2pEAhGSbi0uh7IXggr5yvvenO8wBa8ZtaoNrM3yKM0rm21OC/msBjamnKMioQmKS8kC15S8veBytF4WKoQqwVkUzdpMHYoQADh6mqGIrO3ygVd1tAFeZ4c6/KB4NXuhbawCN4PgRuHg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=La4nfOCJ; arc=fail smtp.client-ip=40.107.74.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RR7WMst9TKtnd+2Ea7DUIyvkCKK6j7g8HpznkrxT0/EuCdsIFA/1kYcpZt0hHgn+4HLFozpgLdzR46T80LsXc9hgLZ8W5g/7gUFH9NqVUZAf40xdG1Q351GekdQKUDKyncHyoR7ieMp1nGc4Aw8JfIW0Aisxe5ix8XnkghpB5SK/hymZl3POu5rnhlKPuAyhcwRjznwrNtXDq8knAHio1tgAEGSQWBEUfRjZeMsMb9aPfMLzsTjLldGZmUE1ChmwpqJAfN8aeDCKJlaMFjzH2h6GX3K9X3xyQmGNMUofoHTtziqNEf2kWLpK205sS0UQ8X1/MCvnKWMyqkvLtvgv7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fc0Ika5nuP40x5RctdQbbjCcNdJmnJm1I+2Fiyir/cA=;
 b=Krun/dwVRc9ZXI9ZUxPNCkJ9W1EY4o0usXE6BiL8NGHx6Gm0UbnD2UR5p7d99r4EoZ7rXt1QdCbCJr3O7zm4XvE1lUoxUcqTu7oZ/CU/Bs5pPhT2jqQr9F2Ntg9rEf5y1VKI2NjogHcGfzTQUXDtb+rd0HWlua49+gU7KnTqdNlhV4SazN6oHQC9kgMy+Q5X1xO5pUoodxO31fSIHE5QLJP8q72oAjqT1vrr4qOZYvduTOfhWx1gvHkkFWpdqfV1gwbYjmKLtgSGLLmxdZN9WfF9x+AOP+hK1sMxMU3ml2l/wNxdHXwyIqThj4meL3NzgsYQai79bxjMQyV31231qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fc0Ika5nuP40x5RctdQbbjCcNdJmnJm1I+2Fiyir/cA=;
 b=La4nfOCJ5sEx8ICGcNpUJ4RSSk2uCTN6NO3ltsvLTuPcgO/1CF/yoV0PhIIPHLT5jPGe9TjQjEtHc+xM5Lka5mIt9W2LNmncJQpa3Yh95FPdo8rQh+oHJ/YLCKR441dwwTew9xkUEQpN92STIsc4J6CHou/lYpmyOcRK9vw3U2w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TY4P286MB7525.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:351::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 06:33:20 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 06:33:20 +0000
Date: Tue, 2 Dec 2025 15:33:19 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, mani@kernel.org, 
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com, corbet@lwn.net, 
	vkoul@kernel.org, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, 
	Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com, kurt.schwemmer@microsemi.com, 
	logang@deltatee.com, jingoohan1@gmail.com, lpieralisi@kernel.org, robh@kernel.org, 
	jbrunet@baylibre.com, fancer.lancer@gmail.com, arnd@arndb.de, pstanner@redhat.com, 
	elfring@users.sourceforge.net
Subject: Re: [RFC PATCH v2 13/27] NTB: ntb_transport: Use seq_file for QP
 stats debugfs
Message-ID: <ge3bqyurfb7didh47rfai7fofsbbci5jui3m2ot42fv4arfyfz@gqi6a4arfo73>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-14-den@valinux.co.jp>
 <aS3xe0CNHeIMUu7P@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS3xe0CNHeIMUu7P@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYCPR01CA0163.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::8) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TY4P286MB7525:EE_
X-MS-Office365-Filtering-Correlation-Id: f9a97036-3e13-4c12-a3ee-08de316caf84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DfckKONQWbbn6gJldB1o0yiPDpRb+H0L+maw6j5ZGYWZ6RHb6zSJyM9Z4HZY?=
 =?us-ascii?Q?ji55cYXxRHVvhCipQCGfphAfFAcqFBAGuhJecOMrVR6AbAno6ODCDeF4Vd5M?=
 =?us-ascii?Q?1Zq4Zb1Zq5s/KmQ0cTRpjzQ4HdUFptn7BvqQwoRtcNILnM11uKmZ9pVQ2kTw?=
 =?us-ascii?Q?o/G0VKUnSCCeIzTgD6ddERD6GHaH+biVyBI69OQhxtXe1YDjIEjjzUpRKn3u?=
 =?us-ascii?Q?g5YKub2eZNevj2VEDyi5Irc6UGrWGlXAp/GDfKZAQ/korgaMGc8uXIjfzKmk?=
 =?us-ascii?Q?1LqSMbxos4lArsuTX588TZDRD3/8pICuLIyWSGX4GnMYyFoVi6wjQQtDAlH7?=
 =?us-ascii?Q?R1MyTbGSVShHf9p0noekdhSwCky/6d9eftEGkKc7EhUAZfBma/oT7GgSM73Z?=
 =?us-ascii?Q?YPbxRRkAw5UWj01/bvTa6DKDhdMXwe+fVyGp5gM3K89q1Ix13hWR3WkiuhSK?=
 =?us-ascii?Q?638Nx2vbsGXWH2yZ1+UoaeuUedchWh5nUhTmSGVfVRQQL6jY3z4sQwnSv1aa?=
 =?us-ascii?Q?ycy0MyUvy7ZmvEuoTTEIuOd6HrRIheyHEu7Vr49f4Oj3CYi+PX52mY7nxGy5?=
 =?us-ascii?Q?vu4KoXsFdSAG1uT3//wW61NExyMcDP0NXix082AcO8KWyDu5sENBYcTmj2eg?=
 =?us-ascii?Q?ojZcoTirIUXPPjIX7ppMMFX1TnItCxA3CH1djCrTEXedwsTwZBn6fURlX8pV?=
 =?us-ascii?Q?u8N+zd+opB3LmYZnTat3SmAo8Pol7zJHU/3uHqHTFwvs64RYNZ+LzgVeRo4c?=
 =?us-ascii?Q?UEa1DTFUgfzt+UhTiDegHEMRIX6cbDSZ2/XmD9xleCG1MDs1NAV7QCRKfIhm?=
 =?us-ascii?Q?2sn82O3KvwPBjeGmd/GMfJvAFUepIiOTTT1NCtmPZxNbv1VTULW1xxb6hu2v?=
 =?us-ascii?Q?PQwMyGm9Ei45g2Y1sbAm4dU/pQvzI3WvZg0PK9+DxoJiQAJ9ucvNYT9MUuUd?=
 =?us-ascii?Q?MJAl4VeF3hI6l3MxDbmmpDDa3bRVQydytlDe4utZSjR1v6LCP0tZijGP19Uf?=
 =?us-ascii?Q?MvfK+pJFzLZ8hvynPHjLQ6TfV6urH6WgkSEDj0uyCt/jh5WrOMDte1/UmXZT?=
 =?us-ascii?Q?njpA/7YZV+E3UV0dPoBCuiRxtDVYLQczkay8i9pa5AlKgGOuS0gSUsVc/xP0?=
 =?us-ascii?Q?tYwURbgeggsqUj7565XbSnFMMCj+ke/cLB19JgVPnauu0ufiRNbNJXfbIbHb?=
 =?us-ascii?Q?AYZ44RWHG//4kf7KAC25r3tZq8/VfXbQ67jwlA490TTWrjhvVd59e0tGNYTe?=
 =?us-ascii?Q?8kCyv9UKvK9uwnjQw9o6sVjIBj+p9dWLkpxhopN2ed0uOr8DJRwJr/K1o9Ze?=
 =?us-ascii?Q?au6y09e9ZtLC1iBLSPTUsQo09yMAfdmOtUKe+RGAakGO9gZy9s814JgqOssb?=
 =?us-ascii?Q?qTWIyBeQBtvl/gDZGXKWDszBQIjEE2bryuvO20Po8D5V6BemhIMEYYI7O7CN?=
 =?us-ascii?Q?OvDpOgH8gI6dxyPLECkXA6ZHiEjWTf1T?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8MLnyRxjZ1Adi4Mwholcd9EDQ3UgJnSux6tLDuYWh7RfEIi2VlLLVnwsTDKR?=
 =?us-ascii?Q?lKGsnJAf+EyV/yBwLSvu9T3P6DakSiZMEz1oVP+6FSvEJJfAZPDh945MomY4?=
 =?us-ascii?Q?kBjo0OR0dKOJZ5Hbw6DkNeduaGAkVBWCErqkp6DU8tgKFmh+mvMg7217jZNY?=
 =?us-ascii?Q?uMfuS2XJhM3a2fjyhfTIWHe2TVgpEeu4vY+ZW6EfnO9ax3KEX59rTg169zjM?=
 =?us-ascii?Q?GqdR4OSKpUrUv9UiyX/0HYohe+ccVZ9lc8mmQcdEejOQe4lq2Re1lcI5NaAN?=
 =?us-ascii?Q?MhGh1BE0wxyoE8qZBKgZKArTnXH6PXXe1wBIHTN5t3aRtNLydxDnpE+tTLea?=
 =?us-ascii?Q?8rN78Z+a73Ge9d7jEZMJLILEhGy0DxFO0FPF0sZnRVcK8wJdtnw0vgChSeNr?=
 =?us-ascii?Q?YNyylLzK505jNBjLIxt7DlhqccRBtQeIcUnfRj1VXESkJjOA9QS11QxXwgkq?=
 =?us-ascii?Q?PBFMtKEksWhgrwZGckKAbuBGe9luiVxQQ2rHSuACkE/oxMfqTFjTmmoAQpkb?=
 =?us-ascii?Q?eIJeQnBYeXzwIFpcuK3zvRq2EtJROcfIRq/WIl0lf+6/U5GzEtbSh9sDuWXX?=
 =?us-ascii?Q?u2uvkeNxamp9JqGoAMrfwKdwvNVEen4oU69UpbGAwxndyhpFIMOMibAUN8kg?=
 =?us-ascii?Q?SdBU1htwkLMJREcPWQk8X6IjZJAP56gl394Udx9L7p/lqwgtHNW8raFEZmYr?=
 =?us-ascii?Q?GNX372nsINmoJ8anXjh26ACdID4B151g+e8mGXpSGwDgW8hSFCfWPBqSXuuk?=
 =?us-ascii?Q?GEbmT24S7F6TN26m0pKYpNUi7l0ypg+NJu5il37RywqznwmZXvGC49lFCeXb?=
 =?us-ascii?Q?xpU1F/v0oGq7EeXCBRmLCdptfbSBcOvHqwE+3tic1/PFwPsZCDDEBNw9knsu?=
 =?us-ascii?Q?L3wyNTTwdrbbfEAyHb4DW+ob7S0LAoG3oScSSu7CsyTUT3XhTBAAvwNccXhM?=
 =?us-ascii?Q?mkwMZb0kzo6ptaR/Ggo0bUDUdEpGHNmZWqSYsdwEfdUp9PDXm8T+jXsQrAv2?=
 =?us-ascii?Q?sLIFqkwoljA8VBL8nDPiC+8Xk2tN/bXUp5ibRvAkMb3vKbipu+4RbHudQNth?=
 =?us-ascii?Q?j4bInX3PkDtLcZV5omVOWEK60KpzTwo6g21lZ28k6BMZpw5wZWJ8hEesIMJi?=
 =?us-ascii?Q?sC9cf4PnQ0EVqU0PohXgypoxanCE5yN/dyNl9o2epHJwZYALQNYugObweqAg?=
 =?us-ascii?Q?/EJA075Aa6pGSFJ7ZXmhfVuOsLXRue8bnR+8qm27g2GvzWIMdkjQHOCW6WDw?=
 =?us-ascii?Q?Fs37QzgZetbByhhhWtSzffy0RWcz8777R3XACwj0ibaJoZPpbOkAOxT6GR56?=
 =?us-ascii?Q?7urqiERnWH0H1oM/fLhoKSXnW0F6KOU9PDe0IT3gt/tYIPRhRvBFB9Vbeb5V?=
 =?us-ascii?Q?+WUW0ySiwIxtmIhHb0QWUTsYUmw9FoW5BY/7GYZvnK1bkduVVtIOReoiczp/?=
 =?us-ascii?Q?frwAWfMXNSISdWbifQwFKUzrq/jwtoTBA8AAVdDHW1oE1CTA6H72k6SRJCVo?=
 =?us-ascii?Q?0anH8QFvbFGWBvr5RD8eL3UFVhqnwG2ylpxK9sCCODdd1YO0zpLkvwqSLDmv?=
 =?us-ascii?Q?HgkB/wuZWNfpxUrh0nInlpH3VGHOAoggUC39kIpeBDUFsyLZvFR7bO0EHCU1?=
 =?us-ascii?Q?f/q82QNbYxqQbt9E3WminLo=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a97036-3e13-4c12-a3ee-08de316caf84
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 06:33:20.5105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gbiHRjsZiDgvweHWrzkWomF7C8CIOPdMF7F/Q/2/VpV39Icwh+l+iOJOHGR99GKo4V0RRaqkJojwF8Iy4tgdFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB7525

On Mon, Dec 01, 2025 at 02:50:19PM -0500, Frank Li wrote:
> On Sun, Nov 30, 2025 at 01:03:51AM +0900, Koichiro Den wrote:
> > The ./qp*/stats debugfs file for each NTB transport QP is currently
> > implemented with a hand-crafted kmalloc() buffer and a series of
> > scnprintf() calls. This is a pre-seq_file style pattern and makes future
> > extensions easy to truncate.
> >
> > Convert the stats file to use the seq_file helpers via
> > DEFINE_SHOW_ATTRIBUTE(), which simplifies the code and lets the seq_file
> > core handle buffering and partial reads.
> >
> > While touching this area, fix a bug in the per-QP debugfs directory
> > naming: the buffer used for "qp%d" was only 4 bytes, which truncates
> > names like "qp10" to "qp1" and causes multiple queues to share the same
> > directory. Enlarge the buffer and use sizeof() to avoid truncation.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> 
> This one is indenpented with other,  you may post seperately. So get merge
> this simple change quick.

Ok I'll do so, thanks.
(it was a semi-preparatory commit for [RFC PATCH v2 20/27], to avoid having
different styles from co-existing.)

Koichiro

> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> >  drivers/ntb/ntb_transport.c | 136 +++++++++++-------------------------
> >  1 file changed, 41 insertions(+), 95 deletions(-)
> >
> > diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> > index 3f3bc991e667..57b4c0511927 100644
> > --- a/drivers/ntb/ntb_transport.c
> > +++ b/drivers/ntb/ntb_transport.c
> > @@ -57,6 +57,7 @@
> >  #include <linux/module.h>
> >  #include <linux/pci.h>
> >  #include <linux/slab.h>
> > +#include <linux/seq_file.h>
> >  #include <linux/types.h>
> >  #include <linux/uaccess.h>
> >  #include <linux/mutex.h>
> > @@ -466,104 +467,49 @@ void ntb_transport_unregister_client(struct ntb_transport_client *drv)
> >  }
> >  EXPORT_SYMBOL_GPL(ntb_transport_unregister_client);
> >
> > -static ssize_t debugfs_read(struct file *filp, char __user *ubuf, size_t count,
> > -			    loff_t *offp)
> > +static int ntb_qp_debugfs_stats_show(struct seq_file *s, void *v)
> >  {
> > -	struct ntb_transport_qp *qp;
> > -	char *buf;
> > -	ssize_t ret, out_offset, out_count;
> > -
> > -	qp = filp->private_data;
> > +	struct ntb_transport_qp *qp = s->private;
> >
> >  	if (!qp || !qp->link_is_up)
> >  		return 0;
> >
> > -	out_count = 1000;
> > -
> > -	buf = kmalloc(out_count, GFP_KERNEL);
> > -	if (!buf)
> > -		return -ENOMEM;
> > +	seq_puts(s, "\nNTB QP stats:\n\n");
> > +
> > +	seq_printf(s, "rx_bytes - \t%llu\n", qp->rx_bytes);
> > +	seq_printf(s, "rx_pkts - \t%llu\n", qp->rx_pkts);
> > +	seq_printf(s, "rx_memcpy - \t%llu\n", qp->rx_memcpy);
> > +	seq_printf(s, "rx_async - \t%llu\n", qp->rx_async);
> > +	seq_printf(s, "rx_ring_empty - %llu\n", qp->rx_ring_empty);
> > +	seq_printf(s, "rx_err_no_buf - %llu\n", qp->rx_err_no_buf);
> > +	seq_printf(s, "rx_err_oflow - \t%llu\n", qp->rx_err_oflow);
> > +	seq_printf(s, "rx_err_ver - \t%llu\n", qp->rx_err_ver);
> > +	seq_printf(s, "rx_buff - \t0x%p\n", qp->rx_buff);
> > +	seq_printf(s, "rx_index - \t%u\n", qp->rx_index);
> > +	seq_printf(s, "rx_max_entry - \t%u\n", qp->rx_max_entry);
> > +	seq_printf(s, "rx_alloc_entry - \t%u\n\n", qp->rx_alloc_entry);
> > +
> > +	seq_printf(s, "tx_bytes - \t%llu\n", qp->tx_bytes);
> > +	seq_printf(s, "tx_pkts - \t%llu\n", qp->tx_pkts);
> > +	seq_printf(s, "tx_memcpy - \t%llu\n", qp->tx_memcpy);
> > +	seq_printf(s, "tx_async - \t%llu\n", qp->tx_async);
> > +	seq_printf(s, "tx_ring_full - \t%llu\n", qp->tx_ring_full);
> > +	seq_printf(s, "tx_err_no_buf - %llu\n", qp->tx_err_no_buf);
> > +	seq_printf(s, "tx_mw - \t0x%p\n", qp->tx_mw);
> > +	seq_printf(s, "tx_index (H) - \t%u\n", qp->tx_index);
> > +	seq_printf(s, "RRI (T) - \t%u\n", qp->remote_rx_info->entry);
> > +	seq_printf(s, "tx_max_entry - \t%u\n", qp->tx_max_entry);
> > +	seq_printf(s, "free tx - \t%u\n", ntb_transport_tx_free_entry(qp));
> > +	seq_putc(s, '\n');
> > +
> > +	seq_printf(s, "Using TX DMA - \t%s\n", qp->tx_dma_chan ? "Yes" : "No");
> > +	seq_printf(s, "Using RX DMA - \t%s\n", qp->rx_dma_chan ? "Yes" : "No");
> > +	seq_printf(s, "QP Link - \t%s\n", qp->link_is_up ? "Up" : "Down");
> > +	seq_putc(s, '\n');
> >
> > -	out_offset = 0;
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "\nNTB QP stats:\n\n");
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "rx_bytes - \t%llu\n", qp->rx_bytes);
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "rx_pkts - \t%llu\n", qp->rx_pkts);
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "rx_memcpy - \t%llu\n", qp->rx_memcpy);
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "rx_async - \t%llu\n", qp->rx_async);
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "rx_ring_empty - %llu\n", qp->rx_ring_empty);
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "rx_err_no_buf - %llu\n", qp->rx_err_no_buf);
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "rx_err_oflow - \t%llu\n", qp->rx_err_oflow);
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "rx_err_ver - \t%llu\n", qp->rx_err_ver);
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "rx_buff - \t0x%p\n", qp->rx_buff);
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "rx_index - \t%u\n", qp->rx_index);
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "rx_max_entry - \t%u\n", qp->rx_max_entry);
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "rx_alloc_entry - \t%u\n\n", qp->rx_alloc_entry);
> > -
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "tx_bytes - \t%llu\n", qp->tx_bytes);
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "tx_pkts - \t%llu\n", qp->tx_pkts);
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "tx_memcpy - \t%llu\n", qp->tx_memcpy);
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "tx_async - \t%llu\n", qp->tx_async);
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "tx_ring_full - \t%llu\n", qp->tx_ring_full);
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "tx_err_no_buf - %llu\n", qp->tx_err_no_buf);
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "tx_mw - \t0x%p\n", qp->tx_mw);
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "tx_index (H) - \t%u\n", qp->tx_index);
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "RRI (T) - \t%u\n",
> > -			       qp->remote_rx_info->entry);
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "tx_max_entry - \t%u\n", qp->tx_max_entry);
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "free tx - \t%u\n",
> > -			       ntb_transport_tx_free_entry(qp));
> > -
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "\n");
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "Using TX DMA - \t%s\n",
> > -			       qp->tx_dma_chan ? "Yes" : "No");
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "Using RX DMA - \t%s\n",
> > -			       qp->rx_dma_chan ? "Yes" : "No");
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "QP Link - \t%s\n",
> > -			       qp->link_is_up ? "Up" : "Down");
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "\n");
> > -
> > -	if (out_offset > out_count)
> > -		out_offset = out_count;
> > -
> > -	ret = simple_read_from_buffer(ubuf, count, offp, buf, out_offset);
> > -	kfree(buf);
> > -	return ret;
> > -}
> > -
> > -static const struct file_operations ntb_qp_debugfs_stats = {
> > -	.owner = THIS_MODULE,
> > -	.open = simple_open,
> > -	.read = debugfs_read,
> > -};
> > +	return 0;
> > +}
> > +DEFINE_SHOW_ATTRIBUTE(ntb_qp_debugfs_stats);
> >
> >  static void ntb_list_add(spinlock_t *lock, struct list_head *entry,
> >  			 struct list_head *list)
> > @@ -1237,15 +1183,15 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
> >  	qp->tx_max_entry = tx_size / qp->tx_max_frame;
> >
> >  	if (nt->debugfs_node_dir) {
> > -		char debugfs_name[4];
> > +		char debugfs_name[8];
> >
> > -		snprintf(debugfs_name, 4, "qp%d", qp_num);
> > +		snprintf(debugfs_name, sizeof(debugfs_name), "qp%d", qp_num);
> >  		qp->debugfs_dir = debugfs_create_dir(debugfs_name,
> >  						     nt->debugfs_node_dir);
> >
> >  		qp->debugfs_stats = debugfs_create_file("stats", S_IRUSR,
> >  							qp->debugfs_dir, qp,
> > -							&ntb_qp_debugfs_stats);
> > +							&ntb_qp_debugfs_stats_fops);
> >  	} else {
> >  		qp->debugfs_dir = NULL;
> >  		qp->debugfs_stats = NULL;
> > --
> > 2.48.1
> >

