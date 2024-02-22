Return-Path: <dmaengine+bounces-1063-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AD585F67C
	for <lists+dmaengine@lfdr.de>; Thu, 22 Feb 2024 12:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D9151F25233
	for <lists+dmaengine@lfdr.de>; Thu, 22 Feb 2024 11:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2B03FB17;
	Thu, 22 Feb 2024 11:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="F/ij3e2R"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14AA3FB1C;
	Thu, 22 Feb 2024 11:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708600009; cv=none; b=gKBU2PswSAUkPEYpjSkURLo3mm0WLCjZq+/TYz4knQtpZ3VLfkRbIF94kuYXHII26Oppn7nj0oNOSpv+3TCarBL1biZPTnf7xZBZus3q45u3e0l7ms3kWiYbe9hWOqDwXG7+nPyTetW7UnVwVh/wvwm8MfTKE5GFd5KxLgUrTjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708600009; c=relaxed/simple;
	bh=y8jkZ00HTRH1afSaWf/PQQ7ciQSOPcr4dnt+ncv31z4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=k7VJcte9fxzL5uav7tmXgYUJ8sR0c4x4szBoHquCytX7p8Mew2ew9xIq9ern5MCloek3wIz5YNsK7QPcyzhMCFbqNyRR1BfHdLYRt6XYKy6Ggx+sx7VsDIddlrOXqcZezKNnXLCAVjrV/jGEyAkNFv8cw9MUwr0PQXMAXitGT78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=F/ij3e2R; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41M7jR1b000314;
	Thu, 22 Feb 2024 11:06:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=jBO+a2S5UySFh7Med/kcvzKEOdD2MLvJYz5WAe5rA6Q=; b=F/
	ij3e2RxIpmYLu/uPQaY/tN86rwTL08ufEhyN11lrSfyrpA0IdL63KImuVHa2q+QO
	uu3Jp54bPXAS8gD01r+JWHF8O+4mRQsTbyshKZWQ8VCHse9TqPcXVTU2DwFKTJ2P
	dS99W8QiYq3PEP7FoSREt1OILqBm334Bex+BC/CZJrVXi2m94Z4Abw08kAQpo867
	ZCU1NzxSrAeNb3dXYKMe9eBIW1RNvOtcSgp6QpLMYA74Vg/yFRAigWOTO2f0v8uZ
	YVtGPHaCHbIMCw07N1aW4Ci0+4H/u4id/5hoIO6+UaTYpCbRquqhMEdNiwnvA1SU
	LuT8VoZn/ZQz+ZeYjrPw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wdvww9amj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 11:06:36 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41MB6Zhg025678
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 11:06:35 GMT
Received: from [10.201.203.60] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 22 Feb
 2024 03:06:31 -0800
Message-ID: <8bdf6506-0a2f-4c35-e5d1-216de163d29b@quicinc.com>
Date: Thu, 22 Feb 2024 16:36:28 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 02/11] crypto: qce - Add bam dma support for crypto
 register r/w
Content-Language: en-US
To: Md Sadre Alam <quic_mdalam@quicinc.com>, <thara.gopinath@gmail.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <linux-crypto@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <quic_varada@quicinc.com>
References: <20231214114239.2635325-1-quic_mdalam@quicinc.com>
 <20231214114239.2635325-3-quic_mdalam@quicinc.com>
From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <20231214114239.2635325-3-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZdTDTw7rK-yUMXwSi5Ck4L_inpNAM9Rr
X-Proofpoint-GUID: ZdTDTw7rK-yUMXwSi5Ck4L_inpNAM9Rr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_09,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 impostorscore=0 mlxlogscore=999 clxscore=1015 phishscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402220088



On 12/14/2023 5:12 PM, Md Sadre Alam wrote:
> Add BAM/DMA support for crypto register read/write.
> With this change multiple crypto register will get
> Written using bam in one go.
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---
>   drivers/crypto/qce/core.h |   9 ++
>   drivers/crypto/qce/dma.c  | 233 ++++++++++++++++++++++++++++++++++++++
>   drivers/crypto/qce/dma.h  |  24 +++-
>   3 files changed, 265 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/qce/core.h b/drivers/crypto/qce/core.h
> index 25e2af45c047..bf28dedd1509 100644
> --- a/drivers/crypto/qce/core.h
> +++ b/drivers/crypto/qce/core.h
> @@ -40,6 +40,8 @@ struct qce_device {
>   	int burst_size;
>   	unsigned int pipe_pair_id;
>   	dma_addr_t base_dma;
> +	__le32 *reg_read_buf;
> +	dma_addr_t reg_buf_phys;
>   	int (*async_req_enqueue)(struct qce_device *qce,
>   				 struct crypto_async_request *req);
>   	void (*async_req_done)(struct qce_device *qce, int ret);
> @@ -59,4 +61,11 @@ struct qce_algo_ops {
>   	int (*async_req_handle)(struct crypto_async_request *async_req);
>   };
>   
> +int qce_write_reg_dma(struct qce_device *qce, unsigned int offset, u32 val,
> +		      int cnt);
> +int qce_read_reg_dma(struct qce_device *qce, unsigned int offset, void *buff,
> +		     int cnt);
> +void qce_clear_bam_transaction(struct qce_device *qce);
> +int qce_submit_cmd_desc(struct qce_device *qce, unsigned long flags);
> +struct qce_bam_transaction *qce_alloc_bam_txn(struct qce_dma_data *dma);
>   #endif /* _CORE_H_ */
> diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
> index 46db5bf366b4..85c8d4107afa 100644
> --- a/drivers/crypto/qce/dma.c
> +++ b/drivers/crypto/qce/dma.c
> @@ -4,12 +4,220 @@
>    */
>   
>   #include <linux/dmaengine.h>
> +#include <linux/dma-mapping.h>
>   #include <crypto/scatterwalk.h>
>   
>   #include "dma.h"
> +#include "core.h"

  alphabetical order

> +
> +#define QCE_REG_BUF_DMA_ADDR(qce, vaddr) \
> +	((qce)->reg_buf_phys + \
> +	 ((uint8_t *)(vaddr) - (uint8_t *)(qce)->reg_read_buf))
> +
> +void qce_clear_bam_transaction(struct qce_device *qce)
> +{
> +	struct qce_bam_transaction *qce_bam_txn = qce->dma.qce_bam_txn;
> +
> +	qce_bam_txn->qce_bam_ce_index = 0;
> +	qce_bam_txn->qce_write_sgl_cnt = 0;
> +	qce_bam_txn->qce_read_sgl_cnt = 0;
> +	qce_bam_txn->qce_bam_ce_index = 0;
> +	qce_bam_txn->qce_pre_bam_ce_index = 0;
> +}
> +

  memset ?

> +static int qce_dma_prep_cmd_sg(struct qce_device *qce, struct dma_chan *chan,
> +			       struct scatterlist *qce_bam_sgl,
> +				int qce_sgl_cnt, unsigned long flags,
> +				enum dma_transfer_direction dir,
> +				dma_async_tx_callback cb, void *cb_param)
> +{

  Fix the alignment.

> +	struct dma_async_tx_descriptor *dma_desc;
> +	struct qce_desc_info *desc;
> +	dma_cookie_t cookie;
> +
> +	desc = qce->dma.qce_bam_txn->qce_desc;
> +
> +	if (!qce_bam_sgl || !qce_sgl_cnt)
> +		return -EINVAL;
> +
> +	if (!dma_map_sg(qce->dev, qce_bam_sgl,
> +			qce_sgl_cnt, dir)) {
> +		dev_err(qce->dev, "failure in mapping sgl for cmd desc\n");
> +		return -ENOMEM;
> +	}
> +
> +	dma_desc = dmaengine_prep_slave_sg(chan, qce_bam_sgl, qce_sgl_cnt,
> +					   dir, flags);
> +	if (!dma_desc) {
> +		pr_err("%s:failure in prep cmd desc\n", __func__);
> +		dma_unmap_sg(qce->dev, qce_bam_sgl, qce_sgl_cnt, dir);
> +		kfree(desc);
> +		return -EINVAL;
> +	}
> +
> +	desc->dma_desc = dma_desc;
> +	desc->dma_desc->callback = cb;
> +	desc->dma_desc->callback_param = cb_param;
> +

  you are overwriting same qce_desc here ?

> +	cookie = dmaengine_submit(desc->dma_desc);
> +
> +	return dma_submit_error(cookie);
> +}
> +
> +int qce_submit_cmd_desc(struct qce_device *qce, unsigned long flags)
> +{
> +	struct qce_bam_transaction *qce_bam_txn = qce->dma.qce_bam_txn;
> +	struct dma_chan *chan = qce->dma.rxchan;
> +	unsigned long desc_flags;
> +	int ret = 0;
> +
> +	desc_flags = DMA_PREP_CMD;
> +
> +	/* For command descriptor always use consumer pipe
> +	 * it recomended as per HPG
> +	 */
> +
> +	if (qce_bam_txn->qce_read_sgl_cnt) {
> +		ret = qce_dma_prep_cmd_sg(qce, chan,
> +					  qce_bam_txn->qce_reg_read_sgl,
> +					qce_bam_txn->qce_read_sgl_cnt,
> +					desc_flags, DMA_DEV_TO_MEM,
> +					NULL, NULL);

  alignment.

> +		if (ret) {
> +			pr_err("error while submiting cmd desc for rx\n");
> +			return ret;
> +		}
> +	}
> +
> +	if (qce_bam_txn->qce_write_sgl_cnt) {
> +		ret = qce_dma_prep_cmd_sg(qce, chan,

   Here chan is still pointing to rxchan. Is this correct ?

> +					  qce_bam_txn->qce_reg_write_sgl,
> +					qce_bam_txn->qce_write_sgl_cnt,
> +					desc_flags, DMA_MEM_TO_DEV,
> +					NULL, NULL);
> +	}
> +
> +	if (ret) {
> +		pr_err("error while submiting cmd desc for tx\n");
> +		return ret;
> +	}
> +
> +	qce_dma_issue_pending(&qce->dma);
> +
> +	return ret;
> +}
> +
> +static void qce_prep_dma_command_desc(struct qce_device *qce,
> +				      struct qce_dma_data *dma, bool read, unsigned int addr,
> +		void *buff, int size)
> +{

  alignment

> +	struct qce_bam_transaction *qce_bam_txn = dma->qce_bam_txn;
> +	struct bam_cmd_element *qce_bam_ce_buffer;
> +	int qce_bam_ce_size, cnt, index;
> +
> +	index = qce_bam_txn->qce_bam_ce_index;
> +	qce_bam_ce_buffer = &qce_bam_txn->qce_bam_ce[index];
> +	if (read)
> +		bam_prep_ce(qce_bam_ce_buffer, addr, BAM_READ_COMMAND,
> +			    QCE_REG_BUF_DMA_ADDR(qce,
> +						 (unsigned int *)buff));
> +	else
> +		bam_prep_ce_le32(qce_bam_ce_buffer, addr, BAM_WRITE_COMMAND,
> +				 *((__le32 *)buff));
> +
> +	if (read) {
> +		cnt = qce_bam_txn->qce_read_sgl_cnt;
> +		qce_bam_ce_buffer = &qce_bam_txn->qce_bam_ce
> +			[qce_bam_txn->qce_pre_bam_ce_index];
> +		qce_bam_txn->qce_bam_ce_index += size;
> +		qce_bam_ce_size = (qce_bam_txn->qce_bam_ce_index -
> +				qce_bam_txn->qce_pre_bam_ce_index) *
> +			sizeof(struct bam_cmd_element);
> +
> +		sg_set_buf(&qce_bam_txn->qce_reg_read_sgl[cnt],
> +			   qce_bam_ce_buffer,
> +				qce_bam_ce_size);
> +
> +		++qce_bam_txn->qce_read_sgl_cnt;
> +		qce_bam_txn->qce_pre_bam_ce_index =
> +					qce_bam_txn->qce_bam_ce_index;
> +	} else {
> +		cnt = qce_bam_txn->qce_write_sgl_cnt;
> +		qce_bam_ce_buffer = &qce_bam_txn->qce_bam_ce
> +			[qce_bam_txn->qce_pre_bam_ce_index];
> +		qce_bam_txn->qce_bam_ce_index += size;
> +		qce_bam_ce_size = (qce_bam_txn->qce_bam_ce_index -
> +				qce_bam_txn->qce_pre_bam_ce_index) *
> +			sizeof(struct bam_cmd_element);
> +
> +		sg_set_buf(&qce_bam_txn->qce_reg_write_sgl[cnt],
> +			   qce_bam_ce_buffer,
> +				qce_bam_ce_size);
> +
> +		++qce_bam_txn->qce_write_sgl_cnt;
> +		qce_bam_txn->qce_pre_bam_ce_index =
> +					qce_bam_txn->qce_bam_ce_index;
> +	}
> +}

  Above piece of hunk can be improved.
    *) Between read/write only array name is different, rest can be made
       common
    *) Can use some standard circular buffer apis, wrapping should be
       taken care of.

> +
> +int qce_write_reg_dma(struct qce_device *qce,
> +		      unsigned int offset, u32 val, int cnt)
> +{
> +	void *buff;
> +	unsigned int reg_addr;
> +
> +	buff = &val;
> +
> +	reg_addr = ((unsigned int)(qce->base_dma) + offset);

  Is this type-cast really required ?
  The entire function can be folded in one line ?

> +	qce_prep_dma_command_desc(qce, &qce->dma, false, reg_addr, buff, cnt);
> +
> +	return 0;
> +}
> +
> +int qce_read_reg_dma(struct qce_device *qce,
> +		     unsigned int offset, void *buff, int cnt)
> +{
> +	void *vaddr;
> +	unsigned int reg_addr;
> +
> +	reg_addr = ((unsigned int)(qce->base_dma) + offset);

  same comment as above.

> +	vaddr = qce->reg_read_buf;
> +
> +	qce_prep_dma_command_desc(qce, &qce->dma, true, reg_addr, vaddr, cnt);
> +	memcpy(buff, vaddr, 4);
> +
> +	return 0;
> +}
> +
> +struct qce_bam_transaction *qce_alloc_bam_txn(struct qce_dma_data *dma)
> +{
> +	struct qce_bam_transaction *qce_bam_txn;
> +
> +	dma->qce_bam_txn = kmalloc(sizeof(*qce_bam_txn), GFP_KERNEL);
> +	if (!dma->qce_bam_txn)
> +		return NULL;
> +
> +	dma->qce_bam_txn->qce_desc = kzalloc(sizeof(struct qce_desc_info),
> +					     GFP_KERNEL);

  only one instance ?

> +	if (!dma->qce_bam_txn->qce_desc) {
> +		kfree(dma->qce_bam_txn);
> +		return NULL;
> +	}
> +
> +	sg_init_table(dma->qce_bam_txn->qce_reg_write_sgl,
> +		      QCE_BAM_CMD_SGL_SIZE);
> +
> +	sg_init_table(dma->qce_bam_txn->qce_reg_read_sgl,
> +		      QCE_BAM_CMD_SGL_SIZE);
> +
> +	qce_bam_txn = dma->qce_bam_txn;
> +
> +	return qce_bam_txn;

  return dma->qce_bam_txn ??

> +}
>   
>   int qce_dma_request(struct device *dev, struct qce_dma_data *dma)
>   {
> +	struct qce_device *qce = container_of(dma, struct qce_device, dma);
>   	int ret;
>   
>   	dma->txchan = dma_request_chan(dev, "tx");
> @@ -31,6 +239,21 @@ int qce_dma_request(struct device *dev, struct qce_dma_data *dma)
>   
>   	dma->ignore_buf = dma->result_buf + QCE_RESULT_BUF_SZ;
>   
> +	dma->qce_bam_txn = qce_alloc_bam_txn(dma);
> +	if (!dma->qce_bam_txn) {
> +		pr_err("Failed to allocate bam transaction\n");
> +		return -ENOMEM;
> +	}
> +
> +	qce->reg_read_buf = dmam_alloc_coherent(qce->dev,
> +						QCE_MAX_REG_READ *
> +				sizeof(*qce->reg_read_buf),
> +				&qce->reg_buf_phys, GFP_KERNEL);

  alignment

> +	if (!qce->reg_read_buf) {
> +		pr_err("Failed to allocate reg_read_buf\n");
> +		return -ENOMEM;
> +	}
> +
>   	return 0;
>   error_nomem:
>   	dma_release_channel(dma->rxchan);
> @@ -41,9 +264,19 @@ int qce_dma_request(struct device *dev, struct qce_dma_data *dma)
>   
>   void qce_dma_release(struct qce_dma_data *dma)
>   {
> +	struct qce_device *qce = container_of(dma,
> +			struct qce_device, dma);
> +
>   	dma_release_channel(dma->txchan);
>   	dma_release_channel(dma->rxchan);
>   	kfree(dma->result_buf);
> +	if (qce->reg_read_buf)

  is this check required ?

> +		dmam_free_coherent(qce->dev, QCE_MAX_REG_READ *
> +				sizeof(*qce->reg_read_buf),
> +				qce->reg_read_buf,
> +				qce->reg_buf_phys);
> +	kfree(dma->qce_bam_txn->qce_desc);
> +	kfree(dma->qce_bam_txn);
>   }
>   
>   struct scatterlist *
> diff --git a/drivers/crypto/qce/dma.h b/drivers/crypto/qce/dma.h
> index 786402169360..f10991590b3f 100644
> --- a/drivers/crypto/qce/dma.h
> +++ b/drivers/crypto/qce/dma.h
> @@ -7,6 +7,7 @@
>   #define _DMA_H_
>   
>   #include <linux/dmaengine.h>
> +#include <linux/dma/qcom_bam_dma.h>
>   
>   /* maximum data transfer block size between BAM and CE */
>   #define QCE_BAM_BURST_SIZE		64
> @@ -14,6 +15,10 @@
>   #define QCE_AUTHIV_REGS_CNT		16
>   #define QCE_AUTH_BYTECOUNT_REGS_CNT	4
>   #define QCE_CNTRIV_REGS_CNT		4
> +#define QCE_BAM_CMD_SGL_SIZE           64
> +#define QCE_BAM_CMD_ELEMENT_SIZE       64
> +#define QCE_DMA_DESC_FLAG_BAM_NWD      (0x0004)
> +#define QCE_MAX_REG_READ               8
>   
>   struct qce_result_dump {
>   	u32 auth_iv[QCE_AUTHIV_REGS_CNT];
> @@ -27,13 +32,30 @@ struct qce_result_dump {
>   #define QCE_RESULT_BUF_SZ	\
>   		ALIGN(sizeof(struct qce_result_dump), QCE_BAM_BURST_SIZE)
>   
> +struct qce_bam_transaction {
> +	struct bam_cmd_element qce_bam_ce[QCE_BAM_CMD_ELEMENT_SIZE];

  Any reason why this is not dmam_alloc_coherent ?

Regards,
  Sricharan

