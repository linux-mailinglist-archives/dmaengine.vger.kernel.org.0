Return-Path: <dmaengine+bounces-1267-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 763BF8716B2
	for <lists+dmaengine@lfdr.de>; Tue,  5 Mar 2024 08:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E07A7B21851
	for <lists+dmaengine@lfdr.de>; Tue,  5 Mar 2024 07:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACD17E10F;
	Tue,  5 Mar 2024 07:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WD3c54wF"
X-Original-To: dmaengine@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E107E0FB
	for <dmaengine@vger.kernel.org>; Tue,  5 Mar 2024 07:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709623367; cv=none; b=kOw0wU3LdIJnk/oKeeD5qnFsj6zCdp0MPOYa3HKxO0bTNzBhfCRKAwbo3UUE2KXeckNu7SKckLARjT53LsWoCFGsaUG4xVyjbKIS+P1dgDI350KWvrF2VUDZ19Yhfh9JGTr3myMV9acYIo9+NW1+YZq17O8D/0iBl7s16ZJuabA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709623367; c=relaxed/simple;
	bh=qjn1MClIVlhpCS2WnOAUFuK98tnfyfZqG2al78vw7V0=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=hATdY3ojFoQurg4sowCZVE0EHLSHFdLLFzWA1OGmZcYjxHudxeD9Ve/zueFje8zuA+YcxXL/CWxrGxi29YyHg0u1RLZXqwpfRvJ4iegf+yLBLgkqxf/HSV9DlI2PjZuP/mZ3PRkyd0XmzXi0KnndvpnkHjxalf4CM4BTesSHxh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=WD3c54wF; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240305071354epoutp022648e16db19384b6c51f46e212c37736~5zOjmLSu92139921399epoutp02I
	for <dmaengine@vger.kernel.org>; Tue,  5 Mar 2024 07:13:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240305071354epoutp022648e16db19384b6c51f46e212c37736~5zOjmLSu92139921399epoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1709622834;
	bh=i0/7wU6maBox3QHG8eiO+M+gy+7QDGcXbrlsWy7wG+M=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=WD3c54wFcGAfwInqvBVUAAi0ILHfepVpx6aey81v8G5lwbhvwDYaWAvrdd+w+XEfB
	 6RvgnL9qQpvWyJJTnVCv63gUjZTUKQfYTz+XfEKLgwAxIFHOwh+F22w1/lmHO6gpVp
	 gM/vF3ZAbulylHFXO8vc6eAoJjWavBgQKpyKvebg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTP id
	20240305071353epcas2p23815bcdcce2643b6616dec4e5d6a5933~5zOjYHsSa3266232662epcas2p2V;
	Tue,  5 Mar 2024 07:13:53 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.88]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Tpmy93G8Gz4x9Q0; Tue,  5 Mar
	2024 07:13:53 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
	epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	BB.C5.18994.136C6E56; Tue,  5 Mar 2024 16:13:53 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20240305071353epcas2p4187f5e0311d9bd706c863f38ccf13869~5zOifERbV0955809558epcas2p4-;
	Tue,  5 Mar 2024 07:13:53 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240305071353epsmtrp2ef2112899a60ebcf642de0a5583771c0~5zOiefrY_2507325073epsmtrp2x;
	Tue,  5 Mar 2024 07:13:53 +0000 (GMT)
X-AuditID: b6c32a4d-743ff70000004a32-c7-65e6c6311a3f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	CE.34.07368.036C6E56; Tue,  5 Mar 2024 16:13:52 +0900 (KST)
Received: from KORCO121695 (unknown [10.229.18.202]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240305071352epsmtip2ea348fecbfe8206b300dec36946eac23~5zOiUQ4SZ3111131111epsmtip2Z;
	Tue,  5 Mar 2024 07:13:52 +0000 (GMT)
From: "bumyong.lee" <bumyong.lee@samsung.com>
To: "'karthikeyan'" <karthikeyan@linumiz.com>, <vkoul@kernel.org>
Cc: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<parthiban@linumiz.com>, <saravanan@linumiz.com>
In-Reply-To: <1553a526-6f28-4a68-88a8-f35bd22d9894@linumiz.com>
Subject: RE: dmaengine: CPU stalls while loading bluetooth module
Date: Tue, 5 Mar 2024 16:13:52 +0900
Message-ID: <000001da6ecc$adb25420$0916fc60$@samsung.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMwipOl/cAOi38P2p1VCUOGtvzp0QMWgtoHrmPNqBA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgk+LIzCtJLcpLzFFi42LZdljTQtfw2LNUg0u3hS1WT/3LarFjtabF
	5V1z2Cx23/7DavFuj6LFzjsnmB3YPDat6mTz2P75FLvH501yAcxR2TYZqYkpqUUKqXnJ+SmZ
	eem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QFuVFMoSc0qBQgGJxcVK+nY2Rfml
	JakKGfnFJbZKqQUpOQXmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZVz8HFPyXr5j94RhzA+M8
	yS5GTg4JAROJzpPTGbsYuTiEBPYwSvRu2M8M4XxilPh9/g8rhPONUeLizg5GmJavr95AJfYy
	SnR82s8C4bxklDi9v48NpIpNQFdi5suDLCC2iICjxIzPl1hBbGaBYolHTYfAJnEK2Ess6lvE
	DmILA9X0TpoAVsMioCJx/OZCZhCbV8BSovn0eiYIW1Di5MwnLBBztCWWLXzNDHGRgsTPp8tY
	IXZZSRy7u4UdokZEYnZnG9g/EgI/2SUWdy1hh2hwkTjw/wIrhC0s8er4Fqi4lMTnd3vZIOx8
	iZlzbrBA2DUSX+/9g4oDHX3mJ1A9B9ACTYn1u/RBTAkBZYkjt6BO45PoOPyXHSLMK9HRJgRh
	qko03ayHmCEtsezMDNYJjEqzkPw1C8lfs5DcPwth1QJGllWMUqkFxbnpqclGBYa6eanl8OhO
	zs/dxAhOklq+Oxhfr/+rd4iRiYPxEKMEB7OSCG/NryepQrwpiZVVqUX58UWlOanFhxhNgaE9
	kVlKNDkfmKbzSuINTSwNTMzMDM2NTA3MlcR577XOTRESSE8sSc1OTS1ILYLpY+LglGpgYnzo
	ws+c8fZEWeTth4z3Ilx9TDLrZ767Icb24kZ+o2zbRe3Dp5f+b1x8mrfgpApXVK2K8zP/7Bih
	s02X3s6XWMP/U/Uzz/uconOrdAM73e7za2Y/jbx54su6HKltlmZSjJqrHUpvPMy+IrjPTSos
	Z7XCM9nHKhtaLR0/X9i+hfNh4rv7SgvZuYI1N/B9mD57R0t1G2+UKNff5k8e7Q+K5y9+YaN2
	81l8nl3ve79pvoycL87+qj3ysfp3kEeL/eywLWlxnqciZz1cu+/IH4OKvxVT3+wUUXhQuHvO
	xdkZKecN705a2RimrXmtyENLQZlx2RTnlnbvrepPWjouxd26ZOb03df88qnf0Xx9S3mMlFiK
	MxINtZiLihMBXnZzaRsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsWy7bCSvK7BsWepBm9OW1msnvqX1WLHak2L
	y7vmsFnsvv2H1eLdHkWLnXdOMDuweWxa1cnmsf3zKXaPz5vkApijuGxSUnMyy1KL9O0SuDKW
	NVxhK/ghV3Hk2VzGBsapEl2MnBwSAiYSX1+9Ye1i5OIQEtjNKHFgySd2iIS0xIvWb6wQtrDE
	/ZYjUEXPGSXe9yxhAUmwCehKzHx5EMjm4BARcJaYey8LJMwsUC5x7cBtJoj6CYwSrXfugQ3i
	FLCXWNS3CGyBsICjRO+kCWBxFgEVieM3FzKD2LwClhLNp9czQdiCEidnPmGBGKot8fTmUzh7
	2cLXzBDHKUj8fLoMbI6IgJXEsbtb2CFqRCRmd7YxT2AUnoVk1Cwko2YhGTULScsCRpZVjJKp
	BcW56bnJhgWGeanlesWJucWleel6yfm5mxjB0aKlsYPx3vx/eocYmTgYDzFKcDArifDW/HqS
	KsSbklhZlVqUH19UmpNafIhRmoNFSZzXcMbsFCGB9MSS1OzU1ILUIpgsEwenVAOTw39Nhlti
	5Td/Rp3Jfd7p0ea27LmV6e22iVKGOy03/zgg7BgbzZEWzMy44n+2xLa539S5jM6dS5DxUprT
	1ijCY3aIN31pDY8b/4qr54MS/io9tl+kF8s4yV3m8MVnrrtL+NR0Ou7t/rP6xy9Dw+wPDFeZ
	NsyKe7hcfpGjxBfJbMUfEa7rEr59uSt0tipx650frObOe15KP+dLkxD+2Rt7zVaDvWCySN6X
	OfZsWX6nHZ2/77ghxvSkJ/JD+Ea+l6mlWVffnD9vImA09Z7r3jtRYn+rRZfyvjZ8VLTw6eTJ
	x1Uf9e/gfjtlX0KTnvXf6+G/9eZxndu2fUrCLK1Haw45L/hi8/3Mz8ycgOmba7JvKrEUZyQa
	ajEXFScCAJau2D8FAwAA
X-CMS-MailID: 20240305071353epcas2p4187f5e0311d9bd706c863f38ccf13869
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240305062038epcas2p143c5e1e725d8a934b0208266a2f78ccb
References: <CGME20240305062038epcas2p143c5e1e725d8a934b0208266a2f78ccb@epcas2p1.samsung.com>
	<1553a526-6f28-4a68-88a8-f35bd22d9894@linumiz.com>

Hello.

> we have encountered CPU stalls in mainline kernel while loading the
> bluetooth module. We have custom board based on rockchip rv1109 soc and
> there is bluetooth chipset of relatek 8821cs. CPU is stalls  while realte=
k
> 8821cs module.
>=20
> Bug/Regression:
> In current mainline, we found CPU is stalls when we load bluetooth module=
.
> git bisect shows commit 22a9d9585812440211b0b34a6bc02ade62314be4
> as a bad, which produce CPU stalls.
>=20
> git show 22a9d9585812440211b0b34a6bc02ade62314be4
> commit 22a9d9585812440211b0b34a6bc02ade62314be4
> Author: Bumyong Lee <bumyong.lee=40samsung.com>
> Date:   Tue Dec 19 14:50:26 2023 +0900
>=20
>      dmaengine: pl330: issue_pending waits until WFP state
>=20
>      According to DMA-330 errata notice=5B1=5D 71930, DMAKILL
>      cannot clear internal signal, named pipeline_req_active.
>      it makes that pl330 would wait forever in WFP state
>      although dma already send dma request if pl330 gets
>      dma request before entering WFP state.
>=20
>      The errata suggests that polling until entering WFP state
>      as workaround and then peripherals allows to issue dma request.
>=20
>      =5B1=5D: https://developer.arm.com/documentation/genc008428/latest
>=20
>      Signed-off-by: Bumyong Lee <bumyong.lee=40samsung.com>
>      Link:
> https://lore.kernel.org/r/20231219055026.118695-1-bumyong.lee=40samsung.c=
om
>      Signed-off-by: Vinod Koul <vkoul=40kernel.org>
>=20
> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c index
> 3cf0b38387ae..c29744bfdf2c 100644
> --- a/drivers/dma/pl330.c
> +++ b/drivers/dma/pl330.c
> =40=40 -1053,6 +1053,9 =40=40 static bool _trigger(struct pl330_thread *t=
hrd)
>=20
>          thrd->req_running =3D idx;
>=20
> +       if (desc->rqtype =3D=3D DMA_MEM_TO_DEV =7C=7C desc->rqtype =3D=3D
> DMA_DEV_TO_MEM)
> +               UNTIL(thrd, PL330_STATE_WFP);
> +
>          return true;
>   =7D
>=20
> By reverting this commit, we have success in loading of bluetooth module.
>=20
>=20

> Output of CPU stalls:
> =23 modprobe hci_uart
> =5B   27.024749=5D Bluetooth: HCI UART driver ver 2.3
> =5B   27.025284=5D Bluetooth: HCI UART protocol Three-wire (H5) registere=
d
> =23 =5B   28.125338=5D dwmmc_rockchip ffc70000.mmc: Unexpected interrupt =
latency
> =5B   33.245339=5D dwmmc_rockchip ffc50000.mmc: Unexpected interrupt late=
ncy
> =5B  326.195321=5D rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> =5B  326.195880=5D rcu:     0-...0: (3 ticks this GP) idle=3De5f4/1/0x400=
00000
> softirq=3D551/552 fqs=3D420
> =5B  326.196621=5D rcu:              hardirqs   softirqs   csw/system
> =5B  326.197115=5D rcu:      number:        0          0            0
> =5B  326.197612=5D rcu:     cputime:        0          0            0   =
=3D=3D>
> 10500(ms)
> =5B  326.198231=5D rcu:     (detected by 1, t=3D2105 jiffies, g=3D-455, q=
=3D17
> ncpus=3D2)
> =5B  326.198823=5D Sending NMI from CPU 1 to CPUs 0:
>=20
> Expected Output:
> =23 modprobe hci_uart
> =5B   30.690321=5D Bluetooth: HCI UART driver ver 2.3
> =5B   30.690852=5D Bluetooth: HCI UART protocol Three-wire (H5) registere=
d
> =23 =5B   31.453586=5D Bluetooth: hci0: RTL: examining hci_ver=3D08 hci_r=
ev=3D000c
> lmp_ver=3D08 lmp_subver=3D8821
> =5B   31.458061=5D Bluetooth: hci0: RTL: rom_version status=3D0 version=
=3D1
> =5B   31.458608=5D Bluetooth: hci0: RTL: loading rtl_bt/rtl8821cs_fw.bin
> =5B   31.465029=5D Bluetooth: hci0: RTL: loading rtl_bt/rtl8821cs_config.=
bin
> =5B   31.483926=5D Bluetooth: hci0: RTL: cfg_sz 25, total sz 36953
> =5B   32.213105=5D Bluetooth: hci0: RTL: fw version 0x75b8f098
> =5B   32.274216=5D Bluetooth: MGMT ver 1.22
> =5B   32.285376=5D NET: Registered PF_ALG protocol family

I discussed this issue. Could you refer to this=5B1=5D?
I haven't received anymore reply from him after that.
If you have any more opinion, please let me know.

=5B1=5D: https://lore.kernel.org/lkml/000001da3869=24ca643fa0=245f2cbee0=24=
=40samsung.com/T/

Best Regards


